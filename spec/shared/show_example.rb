shared_examples('public acess to contact') do
      let(:contact){build_stubbed(:contact,
                       firstname:'LHs',lastname:'Lee')}

      before :each do
        allow(Contact).to receive(:persisted?).and_return(true)
        allow(Contact).to receive(:order).with('lastname, firstname').and_return([contact])
        allow(Contact).to receive(:find).with(contact.id.to_s).and_return(contact)
        allow(Contact).to receive(:save).and_return(true)
        get :show ,id:contact
      end
      it "assigns the requested contact to @contact" do
    #   contact = create(:contact)
    #   get :show, id: contact
       expect(assigns(:contact)).to eq contact
      end
      it "renders the :show template" do
    #    contact = create(:contact)
    #    get :show, id: contact
        expect(response).to render_template :show
      end
end
