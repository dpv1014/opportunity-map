namespace :policy do
  desc "Generate alert when report is next to closed"
  task alert_closed_reports: :environment do
    policies = Policy.where("enable_report_date IS NOT NULL AND enable_report_date <= ? AND enable_historical = ? AND periodic_monitoring_date <> ?", Date.today + 1.day, true, nil)
    policies.each do |policy|
      policy.generate_alert_next_closed
    end
  end
end
