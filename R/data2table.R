## Copyright (C) 2024 Takeshi Abe
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.
##
library(tidyverse)

.main <- function() {
    args <- commandArgs(trailingOnly = TRUE)
    if (length(args) < 1)
        stop("missing arguments")

    input_filename <- args[1]

    data <- readr::read_csv(input_filename, show_col_types = FALSE)

    n <- nrow(data)

    cat("| 標高(m) | 名称 | 都道府県 | 所在地 | 備考 |\r\n")
    cat("|--------+------+--------+--------+-----|\r\n")
    with(data, {
        for (i in seq_len(n)) {
            cat("| ")
            cat(alt[i])
            cat(" | ")
            if (!is.na(url[i]))
                cat(sprintf("[[%s][%s]]", url[i], name[i]))
            else
                cat(name[i])
            cat(" | ")
            cat(pref[i])
            cat(" | ")
            if (!is.na(lat[i]) && !is.na(long[i]))
                cat(sprintf("[[https://maps.gsi.go.jp/#11/%f/%f/][%f,%f]]", lat[i], long[i], lat[i], long[i]))
            cat(" | ")
            if (!is.na(note[i]))
                cat(note[i])
            cat(" |\r\n")
        }
    })
}

.main()
