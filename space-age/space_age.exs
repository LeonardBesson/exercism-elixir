defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :uranus | :neptune

  # Orbital periods in Earth days7
  @orbital_periods %{
    :mercury => 0.2408467,
    :venus   => 0.61519726,
    :earth   => 1.0,
    :mars    => 1.8808158,
    :jupiter => 11.862615,
    :saturn  => 29.447498,
    :uranus  => 84.016846,
    :neptune => 164.79132
  }

  @second_to_year (1.0 / (365.25 * 24 * 60 * 60))

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    seconds_in_year = seconds * @second_to_year

    seconds_in_year / @orbital_periods[planet]
  end
end
