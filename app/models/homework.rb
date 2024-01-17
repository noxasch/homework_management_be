# == Schema Information
#
# Table name: homeworks
#
#  id               :bigint           not null, primary key
#  due_at           :datetime         not null
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  resource_file_id :string
#  subject_id       :bigint           not null
#  teacher_id       :bigint           not null
#
# Indexes
#
#  index_homeworks_on_subject_id  (subject_id)
#  index_homeworks_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (teacher_id => users.id)
#
class Homework < ApplicationRecord
  belongs_to :teacher, -> { where(role: :teacher) }, class_name: 'User', inverse_of: :homeworks
  belongs_to :subject

  has_many :assigned_homeworks, dependent: :destroy

  # SORT_OPTIONS = %i[subject due_at created_at].freeze
  SORT_OPTIONS = {
    subject: {},
    due_at: { due_at: :asc },
    created_at: { created_at: :desc }
  }.freeze

  def self.search(args = {})
    return all if args.blank?

    res = all
    res = res.where('homeworks.title ILIKE :query', query: "%#{args[:q].downcase}%") if args[:q].present?
    res
  end

  def self.sorted_by(sort_by = 'created_at')
    return all if sort_by.blank?

    raise InvalidSortedByOptions, "Invalid sorted by options [#{sort_by}]" unless SORT_OPTIONS.key?(sort_by.to_sym)

    res = all

    return res.includes(:subject).order('subjects.name ASC') if sort_by.to_sym == :subject

    res.order(SORT_OPTIONS[sort_by])
  end

  class InvalidSortedByOptions < StandardError; end
end
