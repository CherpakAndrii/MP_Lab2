(*1*)
fun is_older(date1 : (int * int * int), date2 : (int * int * int)) =
    if #1 date1 < #1 date2 orelse #2 date1 < #2 date2 andalso #1 date1 = #1 date2 orelse #3 date1 < #3 date2 andalso #1 date1 = #1 date2 andalso #2 date1 = #2 date2
	    then true
	    else
		false

(*2*)
  fun number_in_month(date : (int * int * int) list, month : int) =
    if null date
    then 0
    else
  if #2 (hd date) = month
  then 1 + number_in_month(tl date, month)
  else 0 + number_in_month(tl date, month);

(*3*)
  fun number_in_months(date : (int * int * int) list, months : int list) =
    if null months
    then 0
    else
  number_in_month(date, hd months) + number_in_months(date, tl months);

(*4*)
  fun dates_in_month(dates : (int * int * int) list, month : int) =
    if null dates
    then []
    else
  if #2 (hd dates) = month
  then (hd dates)::dates_in_month(tl dates, month)
  else dates_in_month(tl dates, month);

(*5*)
  fun dates_in_months(dates : (int * int * int) list, months : int list) =
    if null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months);

(*6*)
  fun get_nth (lines : string list, n : int) =
    if n = 1
    then hd lines
    else get_nth(tl lines, n - 1);

(*7*)
  fun date_to_string(date : (int * int * int) ) =
    get_nth(["January", "February", "March", "April", "May", "June", "July",
             "August", "September", "October", "November"], #2 date)
             ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date);

(*8*)
  fun number_before_reaching_sum (sum : int, numbers : int list) =
    if null numbers orelse hd numbers >= sum
    then 0
    else 1 + number_before_reaching_sum(sum - hd numbers, tl numbers);

(*9*)
  fun what_month(day : int) =
    if day < 0 orelse day > 365
    then 0-1
    else 1 + number_before_reaching_sum(day, [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]);

(*10*)
  fun month_range(day1 : int, day2 : int) =
    if day1>day2
    then []
    else what_month(day1) :: month_range(day1 + 1, day2);

(*11*)
  fun is_oldest(date : (int*int*int), dates : (int*int*int) list) =
    if null dates
    then true
  else if is_older(date, hd dates) orelse date = hd dates
    then is_oldest(date, tl dates)
  else false;

fun oldest(dates : (int*int*int) list) =
  if null dates
    then NONE
  else if is_oldest(hd dates, tl dates)
    then SOME (hd dates)
  else oldest(tl dates);



(*tests*)
(*1*)
  fun task1_test() =
  if is_older((2003, 11, 10),(2004, 3, 15)) <> true
  then raise Fail "Test 1 failed."
  else

  if is_older((2004, 10, 10),(2004, 11, 15)) <> true
  then raise Fail "Test 2 failed"
  else
  print("Test of task1 passed.");

(*2*)
  fun task2_test() =
  if  number_in_month([(11,34,4),(11,34,4)], 34) <> 2
  then raise Fail "Test 1 failed."
  else

  if number_in_month([(11,34,4),(11,32,4)], 34) <> 1
  then raise Fail"Test 2 failed"
  else
  print("Test of task2 passed.");

(*3*)
  fun task3_test() =
  if  number_in_months([(11,34,4),(11,34,4),(11,3,4)],[34,12,3]) <> 3
  then raise Fail "Test 1 failed."
  else

  if number_in_months([(11,34,4),(11,34,4),(11,3,4)],[34,12,4]) <> 2
  then raise Fail "Test 2 failed"
  else
  print("Test of task3 passed.");

(*4*)
  fun task4_test() =
  if  dates_in_month([(11,34,4),(11,34,5),(11,3,4)],34) <> [(11,34,4),(11,34,5)]
  then raise Fail "Test 1 failed."
  else

  if dates_in_month([(11,34,4),(11,34,5),(11,3,4)],3) <> [(11,3,4)]
  then raise Fail "Test 2 failed"
  else
  print("Test of task4 passed.");

(*5*)
 fun task5_test() =
  if  dates_in_months([(11,34,4),(11,5,5),(11,3,10)],[34,12,3]) <> [(11,34,4),(11,3,10)]
  then raise Fail "Test 1 failed."
  else

  if dates_in_months([(11,34,4),(11,5,5),(11,3,10)],[34,5,3]) <> [(11,34,4),(11,5,5),(11,3,10)]
  then raise Fail "Test 2 failed"
  else
  print("Test of task5 passed.");

(*6*)
  fun task6_test() =
  if  get_nth(["sdfvdc","vsv","fyuf"],1) <> "sdfvdc"
  then raise Fail "Test 1 failed."
  else

  if get_nth(["sdfvdc","vsv","fyuf"],2) <> "vsv"
  then raise Fail"Test 2 failed"
  else
  print("Test of task6 passed.");

(*7*)
 fun task7_test() =
  if  date_to_string(2002,2,28) <> "February 28, 2002"
  then raise Fail "Test 1 failed."
  else

  if date_to_string(2003,1,28) <> "January 28, 2003"
  then raise Fail "Test 2 failed"
  else
  print("Test of task7 passed.");

(*8*)
  fun task8_test() =
  if  number_before_reaching_sum( 1,[1, 2, 3]) <> 0
  then raise Fail "Test 1 failed."
  else

  if number_before_reaching_sum(30,[25, 40, 2]) <> 1
  then raise Fail "Test 2 failed"
  else

  if number_before_reaching_sum(30,[1, 2, 5, 7, 12, 22, 24, 46]) <> 5
  then raise Fail "Test 3 failed"
  else
  print("Test of task8 passed.");

(*9*)
 fun task9_test() =
  if  what_month(250) <> 9
  then raise Fail "Test 1 failed."
  else

  if what_month(144) <> 5
  then raise Fail "Test 2 failed"
  else
  print("Test of task9 passed.");

(*10*)
  fun task10_test() =
  if  month_range(30,32) <> [1,1,2]
  then raise Fail "Test 1 failed."
  else

  if  month_range(250,255) <> [9,9,9,9,9,9]
  then raise Fail "Test 2 failed"
  else
  print("Test of task10 passed.");

(*11*)
fun task11_test() =
  if oldest([(2003, 11, 10),(2004, 3, 15)]) <> SOME(2003, 11, 10)
  then raise Fail "Test 1 failed."
  else

  if oldest([(2004, 10, 10),(2004, 11, 15), (2003, 11, 10),(2004, 3, 15)]) <> SOME(2003, 11, 10)
  then raise Fail "Test 2 failed"
  else
  print("Test of task1 passed.");

(*run testing*)
  task1_test();
  task2_test();
  task3_test();
  task4_test();
  task5_test();
  task6_test();
  task7_test();
  task8_test();
  task9_test();
  task10_test();
  task11_test();
