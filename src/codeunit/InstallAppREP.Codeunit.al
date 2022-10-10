codeunit 50502 "Install App REP"
{
    Subtype = Install;

    trigger OnInstallAppPerDatabase()
    begin
        UpdateReportLayout();
    end;

    trigger OnInstallAppPerCompany()
    begin
        UpdateReportLayout();
    end;


    procedure UpdateReportLayout()
    var
        ReportLayoutSelection: Record "Report Layout Selection";
    begin
        ReportLayoutSelection.SetRange("Report ID", 52012072);
        if ReportLayoutSelection.FindFirst() then begin
            ReportLayoutSelection."Report Layout Description" := './src/layout/RSSalesShipmentREPGPO.rdlc';
            ReportLayoutSelection.Modify();
        end;
    end;
}
