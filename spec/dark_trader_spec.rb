require_relative("../lib/dark_trader")


describe "perform" do
 

	 it "should return crypto_array, as not nil" do
	    expect(perform).not_to be_empty
	  end

	  it "should return an array of a coherent size" do
    expect(perform.size).to be > 2000
  end

end



