shared_examples_for "finding menu items" do
  before(:each) do
    DocumentationPage.should_receive(:find).with(:all).and_return(@menu_items = mock("documents")) 
  end
  
  after(:each) do
    assigns[:menu_items].should == @menu_items
  end
end