<?xml version="1.0" encoding="utf-8"?>
<Document xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
    <CstmrCdtTrfInitn>
        <GrpHdr>
            <MsgId>{{setMaxLength proposalid 8}}</MsgId>
            <CreDtTm>{{dateFormat "" "yyyy-MM-DDTHH:mm:ss"}}</CreDtTm>
            <NbOfTxs>{{numberofxx}}</NbOfTxs>
            <CtrlSum>{{CtrlSum}}</CtrlSum>
            <InitgPty>
                <Nm>{{companybank.DbtrName}}</Nm>
                <Id>
                    <OrgId>
                        <Othr>
                            <Id>{{companybank.OrgNr}}</Id>
                            <SchmeNm>
                                <Cd>CUST</Cd>
                            </SchmeNm>
                        </Othr>
                    </OrgId>
                </Id>
            </InitgPty>
        </GrpHdr>
        {{#each trandetails}}
        {{#ifCompare PayType "==" "Domestic"}}
        <PmtInf>
            {{#ifCompare POBO "!=" ""}}
            <PmtInfId>{{PayRef}} - {{POBO}}</PmtInfId>
            {{else}}
            <PmtInfId>{{PayRef}}</PmtInfId>
            {{/ifCompare}} 
            <PmtMtd>TRF</PmtMtd>
            <BtchBookg>false</BtchBookg>
            <NbOfTxs>1</NbOfTxs>
            <CtrlSum>{{BillAmount}}</CtrlSum>
            {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
            <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
            {{/ifCompare}}
            {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
            <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
            {{/ifCompare}}
            <Dbtr>
                <Nm>{{TrDbtrNm}}</Nm>
                <PstlAdr>
                    <StrtNm>{{TrDbtrAddr}}</StrtNm>
                    <PstCd>{{TrDbtrZip}}</PstCd>
                    <TwnNm>{{TrDbtrCity}}</TwnNm>
                    <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
                    <AdrLine>{{TrDbtrAddr}}, {{TrDbtrZip}}, {{TrDbtrCity}}, {{getCountryCode TrDbtrCtry}}</AdrLine>
                </PstlAdr>
                <Id>
                    <OrgId>
                        <Othr>
                            <Id>ABN_ISO20022</Id>
                        </Othr>
                    </OrgId>
                </Id>
            </Dbtr>
            <DbtrAcct>
                <Id>
                    <IBAN>{{TrDbtrIBAN}}</IBAN>
                </Id>
                <Ccy>{{TrDbtrCur}}</Ccy>
            </DbtrAcct>
            <DbtrAgt>
                <FinInstnId>
                    <BIC>{{TrDbtrBIC}}</BIC>
                </FinInstnId>
            </DbtrAgt>
            <ChrgBr>SHAR</ChrgBr>
            <CdtTrfTxInf>
                <PmtId>
                    {{#ifCompare POBO "!=" ""}}
                    <InstrId>{{PayRef}} - {{POBO}}</InstrId>
                    {{else}}
                    <InstrId>{{PayRef}}</InstrId>
                    {{/ifCompare}} 
                    {{#ifCompare POBO "!=" ""}}
                    <EndToEndId>{{PayRef}} - {{POBO}}</EndToEndId>
                    {{else}}
                    <EndToEndId>{{PayRef}}</EndToEndId>
                    {{/ifCompare}} 
                </PmtId>
                <PmtTpInf>
                    <InstrPrty>NORM</InstrPrty>
                    <SvcLvl>
                        <Cd>NURG</Cd>
                    </SvcLvl>
                    </PmtTpInf>
                <Amt>
                    <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
                </Amt>
                <CdtrAgt>
                    <FinInstnId>
                        <BIC>CHASSGSG</BIC>
                    </FinInstnId>
                </CdtrAgt>
                <Cdtr>
                    <Nm>{{CdtrNm}}</Nm>
                    <PstlAdr>
                        <StrtNm>{{CdtrAddr}}</StrtNm>
                        <PstCd>{{CdtrZip}}</PstCd>
                        <TwnNm>{{CdtrCity}}</TwnNm>
                        <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    </PstlAdr>
                </Cdtr>
                <CdtrAcct>
                <Id>
                    <Othr>
                    <Id>{{CdtrAccount}}</Id>
                    <SchmeNm>
                        <Cd>BBAN</Cd>
                    </SchmeNm>
                    </Othr>
                </Id>
                </CdtrAcct>
                <RgltryRptg>
                <Dtls>
                    <Cd>14</Cd>
                    <Amt Ccy="{{BillCurrency}}">{{BillAmount}}</Amt>
                    <Inf>Skipsutgifter</Inf>
                </Dtls>
                </RgltryRptg>
                <RmtInf>
                    <Ustrd>{{Ref}}</Ustrd>
                </RmtInf>
            </CdtTrfTxInf>
        </PmtInf>
        {{/ifCompare}}
        {{#ifCompare PayType "==" "International IBAN"}}
        {{#ifCompare BillCurrency "==" "EUR"}}
        <PmtInf>
            {{#ifCompare POBO "!=" ""}}
            <PmtInfId>{{PayRef}} - {{POBO}}</PmtInfId>
            {{else}}
            <PmtInfId>{{PayRef}}</PmtInfId>
            {{/ifCompare}} 
            <PmtMtd>TRF</PmtMtd>
            <BtchBookg>false</BtchBookg>
            <NbOfTxs>1</NbOfTxs>
            <CtrlSum>{{BillAmount}}</CtrlSum>
            {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
            <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
            {{/ifCompare}}
            {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
            <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
            {{/ifCompare}}
            <Dbtr>
                <Nm>{{TrDbtrNm}}</Nm>
                <PstlAdr>
                    <StrtNm>{{TrDbtrAddr}}</StrtNm>
                    <PstCd>{{TrDbtrZip}}</PstCd>
                    <TwnNm>{{TrDbtrCity}}</TwnNm>
                    <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
                </PstlAdr>
                <Id>
                    <OrgId>
                        <Othr>
                            <Id>ABN_ISO20022</Id>
                        </Othr>
                    </OrgId>
                </Id>
            </Dbtr>
            <DbtrAcct>
                <Id>
                    <IBAN>{{TrDbtrIBAN}}</IBAN>
                </Id>
                <Ccy>{{TrDbtrCur}}</Ccy>
            </DbtrAcct>
            <DbtrAgt>
                <FinInstnId>
                    <BIC>{{TrDbtrBIC}}</BIC>
                </FinInstnId>
            </DbtrAgt>
            <ChrgBr>SLEV</ChrgBr>
            <CdtTrfTxInf>
                <PmtId>
                    {{#ifCompare POBO "!=" ""}}
                    <InstrId>{{PayRef}} - {{POBO}}</InstrId>
                    {{else}}
                    <InstrId>{{PayRef}}</InstrId>
                    {{/ifCompare}} 
                    {{#ifCompare POBO "!=" ""}}
                    <EndToEndId>{{PayRef}} - {{POBO}}</EndToEndId>
                    {{else}}
                    <EndToEndId>{{PayRef}}</EndToEndId>
                    {{/ifCompare}} 
                </PmtId>
                <PmtTpInf>
                    <InstrPrty>NORM</InstrPrty>
                    <SvcLvl>
                        <Cd>SEPA</Cd>
                    </SvcLvl>
                </PmtTpInf>
                <Amt>
                    <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
                </Amt>
                <CdtrAgt>
                    <FinInstnId>
                        <BIC>{{CdtrBIC}}</BIC>
                    </FinInstnId>
                </CdtrAgt>
                <Cdtr>
                    <Nm>{{CdtrNm}}</Nm>
                    <PstlAdr>
                        <StrtNm>{{CdtrAddr}}</StrtNm>
                        <PstCd>{{CdtrZip}}</PstCd>
                        <TwnNm>{{CdtrCity}}</TwnNm>
                        <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    </PstlAdr>
                </Cdtr>
                <CdtrAcct>
                    <Id>
                        <IBAN>{{CdtrIBAN}}</IBAN>
                    </Id>
                </CdtrAcct>
                <RmtInf>
                    <Ustrd>{{Ref}}</Ustrd>
                </RmtInf>
            </CdtTrfTxInf>
        </PmtInf>
        {{/ifCompare}}
        {{/ifCompare}}
        {{#ifCompare PayType "==" "International IBAN"}}
        {{#ifCompare BillCurrency "!=" "EUR"}}
        <PmtInf>
            {{#ifCompare POBO "!=" ""}}
            <PmtInfId>{{PayRef}} - {{POBO}}</PmtInfId>
            {{else}}
            <PmtInfId>{{PayRef}}</PmtInfId>
            {{/ifCompare}} 
            <PmtMtd>TRF</PmtMtd>
            <BtchBookg>false</BtchBookg>
            <NbOfTxs>1</NbOfTxs>
            <CtrlSum>{{BillAmount}}</CtrlSum>
            {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
            <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
            {{/ifCompare}}
            {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
            <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
            {{/ifCompare}}
            <Dbtr>
                <Nm>{{TrDbtrNm}}</Nm>
                <PstlAdr>
                    <StrtNm>{{TrDbtrAddr}}</StrtNm>
                    <PstCd>{{TrDbtrZip}}</PstCd>
                    <TwnNm>{{TrDbtrCity}}</TwnNm>
                    <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
                </PstlAdr>
                <Id>
                    <OrgId>
                        <Othr>
                            <Id>ABN_ISO20022</Id>
                        </Othr>
                    </OrgId>
                </Id>
            </Dbtr>
            <DbtrAcct>
                <Id>
                    <IBAN>{{TrDbtrIBAN}}</IBAN>
                </Id>
                <Ccy>{{TrDbtrCur}}</Ccy>
            </DbtrAcct>
            <DbtrAgt>
                <FinInstnId>
                    <BIC>{{TrDbtrBIC}}</BIC>
                </FinInstnId>
            </DbtrAgt>
            <ChrgBr>SHAR</ChrgBr>
            <CdtTrfTxInf>
                <PmtId>
                    {{#ifCompare POBO "!=" ""}}
                    <InstrId>{{PayRef}} - {{POBO}}</InstrId>
                    {{else}}
                    <InstrId>{{PayRef}}</InstrId>
                    {{/ifCompare}} 
                    {{#ifCompare POBO "!=" ""}}
                    <EndToEndId>{{PayRef}} - {{POBO}}</EndToEndId>
                    {{else}}
                    <EndToEndId>{{PayRef}}</EndToEndId>
                    {{/ifCompare}} 
                </PmtId>
                <PmtTpInf>
                    <InstrPrty>NORM</InstrPrty>
                    <SvcLvl>
                        <Cd>URGP</Cd>
                    </SvcLvl>
                </PmtTpInf>
                <Amt>
                    <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
                </Amt>
                <CdtrAgt>
                    <FinInstnId>
                        <BIC>{{CdtrBIC}}</BIC>
                    </FinInstnId>
                </CdtrAgt>
                <Cdtr>
                    <Nm>{{CdtrNm}}</Nm>
                    <PstlAdr>
                        <StrtNm>{{CdtrAddr}}</StrtNm>
                        <PstCd>{{CdtrZip}}</PstCd>
                        <TwnNm>{{CdtrCity}}</TwnNm>
                        <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    </PstlAdr>
                </Cdtr>
                <CdtrAcct>
                    <Id>
                        <IBAN>{{CdtrIBAN}}</IBAN>
                    </Id>
                </CdtrAcct>
                <RmtInf>
                    <Ustrd>{{Ref}}</Ustrd>
                </RmtInf>
            </CdtTrfTxInf>
        </PmtInf>
        {{/ifCompare}}
        {{/ifCompare}}
        {{#ifCompare PayType "==" "International NON IBAN"}}
        <PmtInf>
            {{#ifCompare POBO "!=" ""}}
            <PmtInfId>{{PayRef}} - {{POBO}}</PmtInfId>
            {{else}}
            <PmtInfId>{{PayRef}}</PmtInfId>
            {{/ifCompare}} 
            <PmtMtd>TRF</PmtMtd>
            <BtchBookg>false</BtchBookg>
            <NbOfTxs>1</NbOfTxs>
            <CtrlSum>{{BillAmount}}</CtrlSum>
            {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
            <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
            {{/ifCompare}}
            {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
            <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
            {{/ifCompare}}
            <Dbtr>
                <Nm>{{TrDbtrNm}}</Nm>
                <PstlAdr>
                    <StrtNm>{{TrDbtrAddr}}</StrtNm>
                    <PstCd>{{TrDbtrZip}}</PstCd>
                    <TwnNm>{{TrDbtrCity}}</TwnNm>
                    <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
                </PstlAdr>
                <Id>
                    <OrgId>
                        <Othr>
                            <Id>ABN_ISO20022</Id>
                        </Othr>
                    </OrgId>
                </Id>
            </Dbtr>
            <DbtrAcct>
                <Id>
                    <IBAN>{{TrDbtrIBAN}}</IBAN>
                </Id>
                <Ccy>{{TrDbtrCur}}</Ccy>
            </DbtrAcct>
            <DbtrAgt>
                <FinInstnId>
                    <BIC>{{TrDbtrBIC}}</BIC>
                </FinInstnId>
            </DbtrAgt>
            <ChrgBr>SHAR</ChrgBr>
            <CdtTrfTxInf>
                <PmtId>
                    {{#ifCompare POBO "!=" ""}}
                    <InstrId>{{PayRef}} - {{POBO}}</InstrId>
                    {{else}}
                    <InstrId>{{PayRef}}</InstrId>
                    {{/ifCompare}} 
                    {{#ifCompare POBO "!=" ""}}
                    <EndToEndId>{{PayRef}} - {{POBO}}</EndToEndId>
                    {{else}}
                    <EndToEndId>{{PayRef}}</EndToEndId>
                    {{/ifCompare}} 
                </PmtId>
                <PmtTpInf>
                    <InstrPrty>NORM</InstrPrty>
                    <SvcLvl>
                        <Cd>URGP</Cd>
                    </SvcLvl>
                </PmtTpInf>
                <Amt>
                    <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
                </Amt>
                <CdtrAgt>
                    <FinInstnId>
                        <BIC>{{CdtrBIC}}</BIC>
                    </FinInstnId>
                </CdtrAgt>
                <Cdtr>
                    <Nm>{{CdtrNm}}</Nm>
                    <PstlAdr>
                        <StrtNm>{{CdtrAddr}}</StrtNm>
                        <PstCd>{{CdtrZip}}</PstCd>
                        <TwnNm>{{CdtrCity}}</TwnNm>
                        <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    </PstlAdr>
                </Cdtr>
                <CdtrAcct>
                    <Id>
                        <Othr>
                            <Id>{{CdtrAccount}}</Id>
                            <SchmeNm>
                                <Cd>BBAN</Cd>
                            </SchmeNm>
                        </Othr>
                    </Id>
                </CdtrAcct>
                <RgltryRptg>
                <Dtls>
                    <Cd>14</Cd>
                    <Amt Ccy="{{BillCurrency}}">{{BillAmount}}</Amt>
                    <Inf>Skipsutgifter</Inf>
                </Dtls>
                </RgltryRptg>
                <RmtInf>
                    <Ustrd>{{Ref}}</Ustrd>
                </RmtInf>
            </CdtTrfTxInf>
        </PmtInf>        
        {{/ifCompare}}
        {{/each}}
    </CstmrCdtTrfInitn>
</Document>