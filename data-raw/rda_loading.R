# Read and save HSall_members.csv
HSall_members <- read.csv("data_raw/HSall_members.csv")
usethis::use_data(HSall_members, overwrite = TRUE)

# Read and save vote data for each Congress
congresses <- c("91", "97", "102", "107", "117")

for (congress in congresses) {
  file_name <- paste0("HS", congress, "_votes.csv")
  votes_data <- read.csv(paste0("data_raw/", file_name))

  # Use assign() to create a variable with a dynamic name
  assign(paste0("votes_", congress), votes_data)

  # Save the data using the dynamic variable name
  do.call(usethis::use_data, list(as.name(paste0("votes_", congress)), overwrite = TRUE))

  rm(congresses)
  rm(congress)
  rm(file_name)
}

