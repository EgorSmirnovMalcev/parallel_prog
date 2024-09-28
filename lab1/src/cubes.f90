module cubes
  use iso_fortran_env, only: int32, int64, real32, real64
  implicit none
  private

! Доступные вовне функции и подпрограммы
  public :: sim_proc, probability
  
  contains

  ! симуляция одного испытания
  integer(int32) function sim_proc()
    implicit none
    integer(int32) :: n, i
    real(real32) :: u

    call random_seed()
    !call random_seed(put=(/(i, i=1, 1)/))
    sim_proc = 0
    n=6
    do i = 1,2
      call random_number(u)
      u = u*n+1
      sim_proc = sim_proc + floor(u)
    end do
  end function sim_proc

  ! Вычисление вероятности выпадения определенной суммы
  subroutine probability(sum, r)
    implicit none
    integer :: i, sum, r, res
    real(real32) :: equal_sum, equal_r, count_r
    equal_sum = 0
    equal_r = 0
    count_r = 0
    do i = 1, 1000 
      res = sim_proc()
      if (res==sum) then
        equal_sum = equal_sum + 1
      end if
      if (MOD(res,2)==r) then
        count_r = count_r + 1
        if (res==sum) then
          equal_r = equal_r + 1
        end if
      end if
    end do
    print *, "Вероятность события A: ", equal_sum/1000
    print *, "Вероятность события A при условии B: ", equal_r/count_r
  end subroutine probability

end module cubes