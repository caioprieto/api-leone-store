module StateMachines
  module OrderState
    extend ActiveSupport::Concern

    included do
      state_machine :status, initial: :pending do
        state :pending
        state :confirmado
        state :enviado

        event :confirmar do
          transition pending: :confirmado
        end

        event :enviar do
          transition confirmado: :enviado
        end

        before_transition to: :confirmado do |order|
          false unless order.address_present?
        end

        # after_transition to: :rejected do |mdfe|
        #   mdfe.manifest.reject_mdfe
        #   mdfe.notify_duplicity if mdfe.status_code.in?([539, 204])
        #   true
        # end

        # before_transition to: %i[canceled cancelling] do |mdfe|
        #   mdfe.errors.add(:base, :cant_cancel_mdfe_in_transit) unless mdfe.manifest.pending?
        #   mdfe.errors.blank?
        # end
      end
    end
  end
end