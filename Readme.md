Hi! 

This package includes data sets of all United States Congress members ("HSall_members") and their votes of selected Congresses ("HS_votes"), namely 91, 97, 102, 107 and 117.

It also provides two functions to interact with this data:
- loading() generates a list related to House of Representatives data. The user specifies which of the five congresses are to be loaded and the function will yield respective data frames, part of the list, dedicated to all House members and their votes. For instance, loading("91") will create a list called "house" with underlying data frames "votes_91" and "members_91".
- wrangling() then, as a second step to loading(), prepares the members and votes data frames in order to analyze all possible pairs of House representatives and groups them in either same-party pairs (both Democrats / both Republicans) or cross-party pairs. For instance, wrangling("91") will do so for the data frames created in loading("91") and yields all possible pairs of House representatives in Congress 91.

With these two functions, one could examine, for instance, the probability density of voting behavior based on pair type. How has Congress 91 changed in that regard to Congress 117? How much do same-party pairs agree on House roll calls, compared to cross-party pairs? This implication is covered in political polarization research and more specifically, the ideological polarization of the political elite in the United States.

Data sourced via voteview.com. This package is installable via remotes::install_github("CosmicOutlaw/phillomenal").
