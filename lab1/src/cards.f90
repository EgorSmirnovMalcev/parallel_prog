module cards
  use iso_fortran_env, only: int32, int64, real32, real64
  implicit none
  private :: shuffle_deck

! Доступные вовне функции и подпрограммы
  public :: count_prob
  
  contains

  subroutine shuffle_deck(deck)
    use iso_fortran_env
    implicit none
    integer, dimension(:), intent(inout) :: deck
    integer :: i, j, temp,k, m
    real u
    m = size(deck)
    do k=1,2
      do i=1,m
        call random_number(u)
        j = 1 + floor(m*u)
        temp = deck(j)
        deck(j) = deck(i)
        deck(i) = temp
      end do
    end do
  end subroutine shuffle_deck

  subroutine count_prob()
    use iso_fortran_env, only: int32, int64, real32, real64
    implicit none
    
    integer :: trials, i, first_ace, two_first_aces, second_ace
    real :: frequency_A, frequency_A_given_B
    integer, dimension(36) :: deck
    do i = 1, 36
      deck(i) = i
    end do
    trials = 1000000
    second_ace = 0
    first_ace = 0
    two_first_aces = 0

    do i = 1, trials
        call shuffle_deck(deck)

        if (deck(2) <= 4) then
            second_ace = second_ace + 1
        end if
        

        if (deck(1) <= 4) then
            first_ace = first_ace + 1
            if (deck(2) <= 4) then
                second_ace = second_ace + 1
                two_first_aces = two_first_aces + 1
            end if
        end if
    end do

    frequency_A = real(second_ace) / trials
    frequency_A_given_B = real(two_first_aces) / first_ace

    print *, frequency_A
    print *, frequency_A_given_B
  end subroutine count_prob

end module cards