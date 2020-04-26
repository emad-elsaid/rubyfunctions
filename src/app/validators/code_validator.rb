class CodeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    code = Code.new(value)
    errors = record.errors

    return errors.add(attribute, :syntax_error) unless code.valid?

    count = code.functions.size
    errors.add(attribute, :no_functions) if count.zero?
    errors.add(attribute, :many_functions) if count > 1
  end
end
