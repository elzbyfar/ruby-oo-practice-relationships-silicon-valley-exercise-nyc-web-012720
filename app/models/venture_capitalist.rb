class VentureCapitalist

    attr_accessor :name, :total_worth

    @@all_capitalists = []

    def initialize(name, total_worth)
        @name = name
        @total_worth = total_worth
        @@all_capitalists << self 
    end 

# # #   I N S T A N C E   M E T H O D S   # # #

    def offer_contract(startup, type, investment)
        FundingRound.new(startup, self, type, investment)
    end 

    def portfolio
        funding_rounds.map do |round|
            round.startup
        end 
    end 

    def biggest_investment
        funding_rounds.max_by do |round|
            round.investment
        end 
    end 

    def invested(domain)
        rounds = funding_rounds.select do |round|
            round.startup.domain == domain
        end 
        rounds.reduce(0) do |acc, venture| 
            acc + venture.investment
        end 
    end 

    def baller?
        self.total_worth > 1000000000
    end 

# # #   C L A S S   M E T H O D S   # # #

    def self.all
        @@all_capitalists
    end 

    def self.tres_commas_club
        all.select do |capitalist|
            capitalist.baller?
        end 
        # all.select(&:baller?)
    end 

# # #   P R I V A T E   M E T H O D S   # # #

    private

    def funding_rounds
        FundingRound.all.select do |round|
            round.venture_capitalist == self
        end 
    end 

    

end