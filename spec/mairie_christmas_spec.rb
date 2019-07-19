require_relative '../lib/mairie_christmas'

describe "the perform method" do
  it "should return an hash with the town_name and the email" do
    expect(perform).to include('wy-dit-joli-village' => 'mairie.wy-dit-joli-village@wanadoo.fr')
  end

end
