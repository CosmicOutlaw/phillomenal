#' House members data
#'
#' A dataset containing biographical and ideological information about U.S. House Representatives.
#'
#' @format A data frame with the following variables:
#' \describe{
#'   \item{congress}{Integer 1+. The number of the congress that this member's row refers to.}
#'   \item{chamber}{Character. "House", "Senate", or "President". The chamber in which the member served.}
#'   \item{icpsr}{Integer 1-99999. ID code which identifies the member.}
#'   \item{state_icpsr}{Integer 0-99. Identifier for the state represented by the member.}
#'   \item{district_code}{Integer 0-99. Identifier for the district that the member represents within their state.}
#'   \item{state_abbrev}{Character. Two-character postal abbreviation for state.}
#'   \item{party_code}{Integer 1-9999. Identifying code for the member's party.}
#'   \item{occupancy}{Integer 1+. ICPSR occupancy code.}
#'   \item{last_means}{Integer 1-5. ICPSR Attain-Office Code.}
#'   \item{bioname}{Character. Name of the member, surname first.}
#'   \item{bioguide_id}{Character. Member identifier in the Biographical Directory of Congress.}
#'   \item{born}{Integer. Year of member's birth.}
#'   \item{died}{Integer. Year of member's death.}
#'   \item{nominate_dim1}{Numeric. NOMINATE first dimension estimate.}
#'   \item{nominate_dim2}{Numeric. NOMINATE second dimension estimate.}
#'   \item{nominate_log_likelihood}{Numeric. Log-likelihood of the NOMINATE estimate.}
#'   \item{nominate_geo_mean_probability}{Numeric. Geometric mean probability of NOMINATE estimate.}
#'   \item{nominate_number_of_votes}{Integer. Number of votes cast by the member during a given congress.}
#'   \item{conditional}{Integer 0-1. Indicates if NOMINATE was estimated conditionally for a given member.}
#'   \item{nokken_poole_dim1}{Numeric. Nokken-Poole First dimension estimate.}
#'   \item{nokken_poole_dim2}{Numeric. Nokken-Poole Second dimension estimate.}
#' }
#' @name HSall_members
#' @docType data
NULL

#' House votes data for the 91st Congress
#'
#' Dataset containing voting information for the 91st Congress (1969-1971).
#'
#' @format A data frame with the following variables:
#' \describe{
#'   \item{congress}{Integer 1+. The number of the congress for this vote.}
#'   \item{chamber}{Character. "House", "Senate", or "President". The chamber in which the vote occurred.}
#'   \item{rollnumber}{Integer 1+. Starts from 1 in the first rollcall of each congress.}
#'   \item{icpsr}{Integer 1-99999. ID code which identifies the member.}
#'   \item{cast_code}{Integer 0-9. Indicator of how the member voted.
#'     \itemize{
#'       \item 0: Not a member of the chamber when this vote was taken
#'       \item 1: Yea
#'       \item 2: Paired Yea
#'       \item 3: Announced Yea
#'       \item 4: Announced Nay
#'       \item 5: Paired Nay
#'       \item 6: Nay
#'       \item 7: Present (some Congresses)
#'       \item 8: Present (some Congresses)
#'       \item 9: Not Voting (Abstention)
#'     }
#'   }
#'   \item{prob}{Numeric. Estimated probability, based on NOMINATE, of the member making the vote as recorded.}
#' }
#' @name HS91_votes
#' @docType data
NULL

#' House votes data for the 97th Congress
#'
#' Dataset containing voting information for the 97th Congress (1981-1983).
#'
#' @format A data frame with the same structure as HS91_votes.
#' @seealso \code{\link{HS91_votes}} for a detailed description of the variables.
#' @name HS97_votes
#' @docType data
NULL

#' House votes data for the 102nd Congress
#'
#' Dataset containing voting information for the 102nd Congress (1991-1993).
#'
#' @format A data frame with the same structure as HS91_votes.
#' @seealso \code{\link{HS91_votes}} for a detailed description of the variables.
#' @name HS102_votes
#' @docType data
NULL

#' House votes data for the 107th Congress
#'
#' Dataset containing voting information for the 107th Congress (2001-2003).
#'
#' @format A data frame with the same structure as HS91_votes.
#' @seealso \code{\link{HS91_votes}} for a detailed description of the variables.
#' @name HS107_votes
#' @docType data
NULL

#' House votes data for the 117th Congress
#'
#' Dataset containing voting information for the 117th Congress (2021-2023).
#'
#' @format A data frame with the same structure as HS91_votes.
#' @seealso \code{\link{HS91_votes}} for a detailed description of the variables.
#' @name HS117_votes
#' @docType data
NULL
