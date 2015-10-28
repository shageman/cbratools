module EmailSignup
  class EntryManager
    def create(email)
      return if find_by_email(email)
      EmailSignup::Entry.create email: email
    end

    def find_by_email(email)
      EmailSignup::Entry.find_by_email email
    end
  end
end