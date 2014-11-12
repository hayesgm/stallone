module AccountsHelper

  def account_date_path(params={})
    date = params.delete(:date)

    # Build out the proper params from date, if given
    if date != nil
      params.merge!(day: date.day, month: date.month, year: date.year)
    end

    return account_path(params)
  end
end
