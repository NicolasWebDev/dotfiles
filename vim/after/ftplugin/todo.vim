" In the waiting list, sort lines in the form "^DD/MM .*" by dates.
command! -buffer -range SortByDate execute '<line1>,<line2>sort n | <line1>,<line2>sort n /\d\+\//'
