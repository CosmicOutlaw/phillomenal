pacman::p_load(
  dplyr,usethis
)

# Loading function: loads House of Representatives and their votes into a house list, based on user_input and the chosen Congress
loading <- function(user_input) {
  valid_inputs <- c("91", "97", "102", "107", "117")
  if (!user_input %in% valid_inputs) {
    stop("Invalid input. Please choose from the following United States Congresses: 91, 97, 102, 107, 117")
  }

  members_id <- paste0("members_", user_input)
  votes_id <- paste0("votes_", user_input)
  file_id <- paste0("data/HS", user_input, "_votes.csv")

  house <<- list()
  house[[members_id]] <<- read.csv("data/HSall_members.csv") %>%
    filter(chamber == "House") %>%
    filter(congress == user_input)
  house[[votes_id]] <<- read.csv(file_id) %>%
    filter(chamber == "House") %>%
    filter(!icpsr %in% house[[members_id]]$icpsr[house[[members_id]]$chamber == "President"])
}

# Wrangling function:
wrangling <- function(user_input) {
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

  # New code to create pairs and analyze them
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

