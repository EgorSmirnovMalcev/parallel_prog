include "../src/cards.f90"

program card_probability
  use iso_fortran_env, only: int32, int64, real32, real64
  use cards
  implicit none
  call count_prob()

end program card_probability