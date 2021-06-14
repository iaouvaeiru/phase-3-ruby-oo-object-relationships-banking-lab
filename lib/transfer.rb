require 'pry'
class Transfer
  attr_accessor :sender, :receiver, :status, :amount
  def initialize(sender, receiver, amount, status = 'pending')
    @sender = sender
    @receiver = receiver
    @status = status
    @amount = amount
  end
  def valid?
    sender.valid? && receiver.valid?
  end
  def execute_transaction
    if self.valid? && self.status == "pending" && sender.balance > self.amount
      sender.balance -= self.amount
      receiver.balance += self.amount
      self.status = 'complete'
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end
  def reverse_transfer
    if status == 'complete'
      sender.balance += self.amount
      receiver.balance -= self.amount
      self.status = 'reversed'
    end
  end
end
