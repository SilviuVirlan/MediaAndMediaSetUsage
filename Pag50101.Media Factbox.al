page 50101 "Media Factbox"
{
    Caption = 'Media';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = MediaTable;

    layout
    {
        area(content)
        {
            field(Image; Rec.Image)
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the picture of the record';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: InStream;
                    ClientFileName: Text;
                begin
                    Rec.TestField("Code");

                    if Rec.Image.Count > 0 then
                        if not Confirm(OverrideImageQst) then
                            exit;


                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        if FromFileName = '' then
                            exit;

                        Clear(Rec.Image);
                        Rec.Image.ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;

                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    ToFile: Text;
                    ExportPath: Text;
                    index: integer;
                    FileName: Text[100];
                    InStreamPic: InStream;
                    TenantMedia: Record "Tenant Media";
                begin

                    Rec.TestField("Code");


                    If Rec.Image.Count = 0 then
                        exit;

                    For index := 1 to Rec.Image.Count do begin
                        if TenantMedia.Get(Rec.Image.Item(index)) then begin
                            TenantMedia.CalcFields(Content);
                            if TenantMedia.Content.HasValue then begin
                                FileName := Rec.TableCaption + '_' + format(Index) + GetImageFileExtension(TenantMedia);
                                TenantMedia.Content.CreateInStream(InStreamPic);
                                DownloadFromStream(InStreamPic, '', '', '', FileName);
                            end;
                        end;
                    end;

                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    Rec.TestField(Code);

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec.Image);
                    Rec.Modify(true);
                end;
            }
        }
    }
    local procedure GetImageFileExtension(var TenantMedia: Record "Tenant Media"): Text;
    begin
        case TenantMedia."Mime Type" of
            'image/jpeg':
                exit('.jpg');
            'image/bmp':
                exit('.bmp');
            'image/gif':
                exit('.gif');
            'image/png':
                exit('.png');
            'image/tiff':
                exit('.tiff');
        end;
    end;

    var
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        MustSpecifyNameErr: Label 'You must specify a customer name before you can import a picture.';

}

