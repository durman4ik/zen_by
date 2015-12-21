class Calendar
  include Mongoid::Document

  field :jan
  field :feb
  field :mar
  field :apr
  field :may
  field :jun
  field :jul
  field :aug
  field :sep
  field :oct
  field :nov
  field :dec

  embedded_in :tour
  embedded_in :special_tour

end
