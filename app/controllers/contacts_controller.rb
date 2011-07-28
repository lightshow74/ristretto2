class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.xml
  def index
    @customer = Customer.find(params[:customer_id])
    @contacts = @customer.contacts

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @customer = Customer.find(params[:customer_id])
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @customer = Customer.find(params[:customer_id])
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @customer = Customer.find(params[:customer_id])
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @customer = Customer.find(params[:customer_id])
    @user = User.invite!({:email => params[:contact][:email]}, current_user)
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        format.html { redirect_to(customer_contact_url(@customer, @contact), :notice => 'Contact was successfully created.') }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @customer = Customer.find(params[:customer_id])
    @contact = Contact.find(params[:id], :readonly => false)

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to(customer_contact_url(@customer, @contact), :notice => 'Contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @customer = Customer.find(params[:customer_id])
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(customer_contacts_url(@customer)) }
      format.xml  { head :ok }
    end
  end
end
