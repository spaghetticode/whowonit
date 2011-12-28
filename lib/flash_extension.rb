module FlashExtension
  def show_and_delete(key)
    message = self[key]
    delete(key)
    message
  end
end