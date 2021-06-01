table 50100 MediaTable
{
    Caption = 'MediaTable';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Image; MediaSet)
        {
            Caption = 'Image';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(Brick; Code, Image)
        {

        }
    }

}
permissionset 50100 MediaPErmissions
{
    Assignable = true;
    Caption = 'Media PErmissions';
    Permissions =
        tabledata MediaTable = RIMD;
}