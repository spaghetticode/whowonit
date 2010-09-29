def it_should_redirect_for(actions)
  actions.each do |action, method|
    it "should redirect for #{method} #{action}" do
      send(method, action, :id => '1')
      response.should be_redirect
    end
  end
end