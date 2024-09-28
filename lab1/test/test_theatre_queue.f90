include "../src/theatre_queue.f90"

program test_theatre_queue
  use iso_fortran_env, only: int32, int64, real32, real64
  use theatre_queue
  implicit none
  integer(int32) :: n, m, i
  logical :: f
  print *, "Введите n: "
  read (*,*) n
  m=5
  print *, probability(n)
  do i = 1, m
    f = sim_proc(n, .true.)
  end do
end program test_theatre_queue