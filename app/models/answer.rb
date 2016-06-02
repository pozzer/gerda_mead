class Answer < ActiveRecord::Base
	belongs_to :user
	belongs_to :question

  scope :the_best, -> { where(:best => true) }

  def voted_the_best
    self.update_attributes(best: true) if !self.question.have_best_answer?
  end

  def creator?(user_id)
    user_id == self.user_id
  end
  
  def can_edit?(user_id)
    ((Time.now - created_at ) < 5.minutes) and creator?(user_id)
  end
end
