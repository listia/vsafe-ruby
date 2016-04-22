module VSafe
  class CardType
    AMERICAN_EXPRESS = 3
    VISA = 4
    MASTERCARD = 5
    DISCOVER = 6
    DINERS_CLUB = 7
    OPTIMA = 10

    HUMANIZED_NAMES = {
      AMERICAN_EXPRESS => "American Express".freeze,
      VISA => "Visa".freeze,
      MASTERCARD => "MasterCard".freeze,
      DISCOVER => "Discover".freeze,
      DINERS_CLUB => "Diners Club".freeze,
      OPTIMA => "Optima".freeze
    }

    attr_reader :code

    def initialize(code)
      @code = code.to_i
    end

    def description
      HUMANIZED_NAMES[code]
    end
  end
end
