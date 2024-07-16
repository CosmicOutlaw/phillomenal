library(dplyr)
library(usethis)

#' @import dplyr
NULL

#' @importFrom utils combn
NULL

#'@importFrom magrittr %>%
#'@export %>%
#'@title Loading of U.S. House data sets.
#'@description Loads United States House Representatives and their votes into a house list, based on the user's chosen Congress.
#'@param user_input Number equalling either 91, 97, 102, 107 or 117.
#'@return A list object 'house' containing members and their votes of a chosen Congress. This can be done repetitively, for multiple congresses.
#'@export
#'@examples
#'loading("91")
#'loading("97")
loading <- function(user_input) {

  valid_inputs <- c("91", "97", "102", "107", "117")
  if (!user_input %in% valid_inputs) {
    stop("Invalid input. Please choose from the following United States Congresses: 91, 97, 102, 107, 117")
  }

  members_id <- paste0("members_", user_input)
  votes_id <- paste0("votes_", user_input)

  house <<- list()
  house[[members_id]] <<- HSall_members %>%
    filter(chamber == "House") %>%
    filter(congress == user_input)

  house[[votes_id]] <<- get(paste0("votes_", user_input)) %>%
    filter(chamber == "House") %>%
    filter(!icpsr %in% house[[members_id]]$icpsr[house[[members_id]]$chamber == "President"])
}

#'@title Wrangling of U.S. House data sets
#'@description Wrangles the objects created in loading(), namely votes_id and members_id, by merging select columns of both objects. Specifically,
#'votes_id is being enhanced by information about each representative in order to allow the creation of pairs_id for the chosen Congress.
#'@param user_input Number equaling either 91, 97, 102, 107 or 117.
#'@return An updated votes_id, pairs_id which displays all possible pairs of representatives in a given Congress.
#'@export
#'@examples
#'loading("91")
#'wrangling("91")
wrangling <- function(user_input) {

  if (!exists("house") || !is.list(house) || length(house) == 0) {
    stop("Please run loading() function first to create the house object.")
  }

  valid_inputs <- c("91", "97", "102", "107", "117")
  if (!user_input %in% valid_inputs) {
    stop("Invalid input. Please choose from the following United States Congresses: 91, 97, 102, 107, 117")
  }

  votes_id <- paste0("votes_", user_input)
  members_id <- paste0("members_", user_input)
  pairs_id <- paste0("pairs_", user_input)

  house[[votes_id]] <<- house[[votes_id]] %>%
    left_join(
      select(house[[members_id]],
             icpsr,
             party_code,
             bioname),
      by = "icpsr") %>%
    arrange(icpsr, rollnumber)

  house[[pairs_id]] <<- t(combn(unique(house[[votes_id]]$icpsr), 2))
  colnames(house[[pairs_id]]) <- c("icpsr1", "icpsr2")

  house[[pairs_id]] <<- house[[pairs_id]] %>%
    as.data.frame() %>%
    merge(., house[[members_id]][, c("icpsr", "party_code")], by.x = "icpsr1", by.y = "icpsr", all.x = TRUE) %>%
    rename(party_code1 = party_code) %>%
    merge(., house[[members_id]][, c("icpsr", "party_code")], by.x = "icpsr2", by.y = "icpsr", all.x = TRUE) %>%
    rename(party_code2 = party_code) %>%
    select(icpsr1, party_code1, icpsr2, party_code2) %>%
    mutate(
      pair_type = ifelse(party_code1 == party_code2, "SPP", "CPP")
    ) %>%
    mutate(
      pair_type = factor(pair_type, levels = c("CPP", "SPP"))
    ) %>%
    mutate(
      pair_type2 = case_when(
        party_code1 == 100 & party_code2 == 100 ~ "D-D",
        party_code1 == 200 & party_code2 == 200 ~ "R-R",
        TRUE ~ "CPP")) %>%
    arrange(icpsr1, icpsr2)
}
