require 'spec_helper'

describe Ability, "Documentation page abilities" do
  context "User is not logged in" do
    before(:each) do
      @ability = Ability.new(nil)
    end

    it "should be able to read a documentation page" do
      @ability.can?(:read, DocumentationPage.new).should be_true
    end

    it "should be not be able to create a documentation page" do
      @ability.can?(:create, DocumentationPage).should be_false
    end

    it "should not be able to update a documentation page" do
      @ability.can?(:update, DocumentationPage).should be_false
    end

    it "should not be able to destroy a documentation page" do
      @ability.can?(:destroy, DocumentationPage).should be_false
    end
  end

  context "User is logged in" do
    before(:each) do
      @user = mock_model(User, :admin => false, :moderator => false, :author => false)
      @ability = Ability.new(@user)
    end

    context "All registered users are document authors" do
      before(:each) do
        @config = mock_model(SiteConfig, :use_document_author_list => false)
      end

      it "should be able to read a documentation page" do
        @ability.can?(:read, DocumentationPage.new).should be_true
      end

      it "should be able to create a documentation page" do
        @ability.can?(:create, DocumentationPage).should be_true
      end

      it "should be able to update a documentation page" do
        @ability.can?(:update, DocumentationPage.new).should be_true
      end

      it "should be able to destroy a documentation page" do
        @ability.can?(:destroy, DocumentationPage.new).should be_true
      end
    end
    context "The document author list is in use" do
      before(:each) do
        @config = mock_model(SiteConfig, :use_document_author_list => true)
        SiteConfig.stub!(:find_or_create_default!).and_return(@config)
        @ability = Ability.new(@user)
      end

      context "User is not a document author" do

        it "should be able to read a documentation page" do
          @ability.can?(:read, DocumentationPage.new).should be_true
        end

        it "should not be able to create a documentation page" do
          @ability.can?(:create, DocumentationPage).should be_false
        end

        it "should not be able to update a documentation page" do
          @ability.can?(:update, DocumentationPage.new).should be_false
        end

        it "should not be able to destroy a documentation page" do
          @ability.can?(:destroy, DocumentationPage.new).should be_false
        end
      end

      context "User is a document author" do
        before(:each) do
          @user.stub!(:author).and_return(true)
          @ability = Ability.new(@user)
        end
        
        it "should be able to read a documentation page" do
          @ability.can?(:read, DocumentationPage.new).should be_true
        end

        it "should be able to create a documentation page" do
          @ability.can?(:create, DocumentationPage).should be_true
        end

        it "should be able to update a documentation page" do
          @ability.can?(:update, DocumentationPage.new).should be_true
        end

        it "should be able to destroy a documentation page" do
          @ability.can?(:destroy, DocumentationPage.new).should be_true
        end
      end
    end
  end

  context "User is a moderator" do
    before(:each) do
      @user = mock_model(User, :admin => false, :moderator => true, :author => false)
      @ability = Ability.new(@user)
    end

    context "All registered users are document authors" do
      it "should be able to read a documentation page" do
        @ability.can?(:read, DocumentationPage.new).should be_true
      end

      it "should be able to create a documentation page" do
        @ability.can?(:create, DocumentationPage).should be_true
      end

      it "should be able to update a documentation page" do
        @ability.can?(:update, DocumentationPage.new).should be_true
      end

      it "should be able to destroy a documentation page" do
        @ability.can?(:destroy, DocumentationPage.new).should be_true
      end
    end

    context "The document author list is in use" do
      before(:each) do
        @config = mock_model(SiteConfig, :use_document_author_list => true)
        SiteConfig.stub!(:find_or_create_default!).and_return(@config)
        @ability = Ability.new(@user)
      end

      it "should be able to read a documentation page" do
        @ability.can?(:read, DocumentationPage.new).should be_true
      end

      it "should not be able to create a documentation page" do
        @ability.can?(:create, DocumentationPage).should be_false
      end

      it "should not be able to update a documentation page" do
        @ability.can?(:update, DocumentationPage.new).should be_false
      end

      it "should not be able to destroy a documentation page" do
        @ability.can?(:destroy, DocumentationPage.new).should be_false
      end
    end
  end

  context "User is an administrator" do
    before(:each) do
      @user = mock_model(User, :admin => true, :moderator => false)
      @ability = Ability.new(@user)
    end

    it "should be able to read a documentation page" do
      @ability.can?(:read, DocumentationPage.new).should be_true
    end

    it "should be able to create a documentation page" do
      @ability.can?(:create, DocumentationPage).should be_true
    end

    it "should be able to update a documentation page" do
      @ability.can?(:update, DocumentationPage.new).should be_true
    end

    it "should be able to destroy a documentation page with no children" do
      @ability.can?(:destroy, DocumentationPage.new).should be_true
    end

    it "should not be able to destroy a documentation page with children" do
      @doc_page = DocumentationPage.new
      @doc_page.children << DocumentationPage.new
      @ability.can?(:destroy, @doc_page).should be_false
    end
  end
end