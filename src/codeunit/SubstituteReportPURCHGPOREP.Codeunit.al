codeunit 50501 "Substitute Report PURCHGPO REP"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin

        case ReportId of
            Report::"Sales - Shipment":
                NewReportId := Report::"RS - Sales Shipment GPO";
        end;
    end;

}
