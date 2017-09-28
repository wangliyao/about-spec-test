class ContactsController < ApplicationController
  def show
    @contact = Contact.find(params[:id])
  end

  def create
    @contact = Contact.new(params_permit)
    if @contact.save
      redirect_to ({:controller => 'contacts', :action => 'show',:id=>@contact.id})
    else
      render action: :new
    end
  end

  def new
    @contact = Contact.new
  end

  def index
    @contacts = Contact.all
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if   @contact.update_attributes(params_permit)
       redirect_to ({:controller => 'contacts', :action => 'show',:id=>@contact.id})
    else
      render edit_contact
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
  end

  private

  def params_permit
    params.require(:contact).permit('firstname','lastname','email')
  end
end
