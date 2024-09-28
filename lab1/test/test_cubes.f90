include "../src/cubes.f90"

program test_cubes
  use iso_fortran_env, only: int32, int64, real32, real64
  use cubes
  implicit none
  integer(int32) :: sum, r
  print *, "Введите сумму: "
  read (*,*) sum
  print *, "Введите остаток: "
  read (*,*) r
  call probability(sum, r)
end program test_cubes