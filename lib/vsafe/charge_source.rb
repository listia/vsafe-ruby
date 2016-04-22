module VSafe
  class ChargeSource
    # Use this to specify that the payment has been prearranged. This is used
    # when the payment device has been validated or already had a successful
    # charge against it. When this option is used, the ChargeCVN is not required.
    PPD = "PPD"
    # Use this to specify that the payment has been taken over the telephone.
    TEL = "TEL"
    # Use this to specify that the payment has been taken over the Web.
    WEB = "WEB"
  end
end
