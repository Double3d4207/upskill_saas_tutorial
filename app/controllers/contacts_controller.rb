class ContactsController <ApplicationController
  
  # GET request to  contact-us
  # SHow new form cotact from
  def new
    @contact = Contact.new
  end
  
  #POST reuqest /contacts
  def create
    # Mass assignment of fomr fields to Contact object
    @contact = Contact.new(contact_params)
    # SAVE the contact object to the database
    if @contact.save
      # Store form fields via parameters, into variables
        name =  params[:contact][:name]
        email = params[:contact][:email]
        body = params[:contact][:comments]
        # Plug variables into ContactMailer 
        # email method and send email
        ContactMailer.contact_email(name, email, body).deliver
        # Store success message in flash hash
        # And redirect to the new action
        flash[:success] = "Message sent."
       redirect_to new_contact_path
    else
      # If contact object dont save,
      # store errors in flash hash
      # and redirect to the new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
       redirect_to new_contact_path
    end
  end
  
  private
    # To collect data from form we need to use
    # strong paramters and white list form fields
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
end