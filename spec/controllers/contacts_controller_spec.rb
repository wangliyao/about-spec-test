require 'spec_helper'

RSpec.describe ContactsController, type: :controller do
  describe'GET#show'do
      it_behaves_like "public acess to contact"
   end

   describe "GET # index" do
     context 'with params[:letter]' do
      it "populates an array of contact starting the letter" do
  #       smith = create(:contact,lastname: "Smith")
  #       jones = create(:contact,lastname: "Jones")
  #       get :index,letter: 'S'
  #       binding.pry
  #       expect(assigns(:contacts)).to match_array([smith])
       end

       it "renders the :index view" do
         get :index, letter: 'S'
         expect(response).to render_template :index
       end
     end
   end

   describe "GET # NEW" do
     it "assigns a new Contact to @contact" ,focus: true do
         get :new
         expect(assigns(:contact)).to be_a_new(Contact)
     end

     it 'render to new template' do
         get :new
         expect(response).to render_template :new
     end
   end

   describe'GET#edit'do
     it "assigns the requested contact to @contact" do
         contact = create(:contact)
         get :edit, id: contact
         expect(assigns(:contact)).to eq contact
     end

     it "renders the :edit template" do
         contact = create(:contact)
         get :edit, id: contact
         expect(response).to render_template :edit
     end
   end

   describe "POST # create" do
     before :each do
       @phone = [
          attributes_for(:phone),
          attributes_for(:phone),
          attributes_for(:phone)
       ]
     end

     context "with valid attribute" do
       it "saves the new contact in the database" do
         expect{
           post :create, contact: attributes_for(:contact,
                  phones_attributes: @phones)
         }.to change(Contact, :count).by(1)
       end

       it "redirects to contacts#show" do
         post :create, contact: attributes_for(:contact,
                phones_attributes: @phones)
         expect(response).to redirect_to contact_path(assigns[:contact])
       end
     end

     context "with invalid attribute" do
       it "does not save the new contact in the database" do
         expect{
           post :create,
             contact: attributes_for(:invalid_contact)
         }.to change(Contact, :count)
       end
     end
   end

   describe "PATH # update" do
    let(:contact) do
       create(:contact,
                 firstname:'LHS' ,lastname: "lee")

    end
     #let(:contact){build_stubbed(:contact,
      #                     firstname:'LHs',lastname:'lee')}


     context "valid attributes" do
       it 'locates the requested @contact' do
         patch :update ,id: contact, contact:attributes_for(:contact)
         expect(assigns(:contact)).to eq(contact)
       end

       it 'changes @contact attribute' do
         patch :update ,id: contact,contact:attributes_for(:contact,
               firstname: 'Larry',lastname: 'Smith')
         contact.reload
         expect(contact.firstname).to eq("Larry")
         expect(contact.lastname).to eq('Smith')
       end

       it 'redirect to the update contact' do
         patch :update ,id: contact,contact:attributes_for(:contact)
         expect(response).to redirect_to contact
       end
     end
   end

   describe 'DELETE # destory' do
     before :each do
       @contact= create(:contact)
     end

     it 'delete the contact' do
       expect{
         delete :destroy, id:@contact
       }.to change(Contact,:count).by(-1)
     end
   end
end
