pageextension 50502 "Bank Account REP" extends "Bank Account Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Print on Footer Document REP"; "Print on Footer Document REP")
            {
                ApplicationArea = all;
            }
        }
    }
}
