module theatre_queue
  use iso_fortran_env, only: int32, int64, real32, real64
  implicit none
  private

! Доступные вовне функции и подпрограммы
  public :: sim_proc, probability
  
  contains

  ! симуляция одной очереди
  logical function sim_proc(n, need_log)
    implicit none
    integer(int32) :: n, sum, good_buyers, i
    real(real32) :: u
    logical :: need_log

    call random_seed()
    !call random_seed(put=(/(i, i=1, 1)/))
    open(unit=10, file="logs/queue.txt", action='write', position='append')

    sim_proc = .true.
    good_buyers = n
    sum = 0
    do i = 0, 2*n-1
      call random_number(u)
      if (floor(u * (2 * n - i)) < good_buyers) then
        sum = sum - 1
        good_buyers = good_buyers - 1
      else
        sum = sum + 1
        if (sum > 0) then
          sim_proc = .false.
        end if
      end if
      if (need_log) then
        write(10, "(i5)", ADVANCE="NO") sum
      end if

    end do
    close(10)
    sim_proc = sim_proc
    
  end function sim_proc

  ! Вычисление вероятности хорошей очереди
  real(real32) function probability(n)
    implicit none
    integer(int32) :: i, n
    real(real32) :: good_ways
    good_ways = 0
    do i = 1, 1000 * n 
      if (sim_proc(n, .false.)) then
        good_ways = good_ways + 1
      end if
    end do
    probability = good_ways / n / 1000
  end function probability

end module theatre_queue