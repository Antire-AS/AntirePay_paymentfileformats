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
    {{#ifCompare PayTypeNO "==" "Domestic"}}	
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId>
        <PmtMtd>TRF</PmtMtd>
        <PmtTpInf>
            <SvcLvl>
                <Prtry>NURG</Prtry>
            </SvcLvl>
            <CtgyPurp>
                <Cd>SUPP</Cd>
            </CtgyPurp>
        </PmtTpInf>
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        <Dbtr>
            <Nm>{{TrDbtrNm}}</Nm>
            <CtryOfRes>{{getCountryCode TrDbtrCtry}}</CtryOfRes>
        </Dbtr>
        <DbtrAcct>
            <Id>
                <IBAN>{{TrDbtrIBAN}}</IBAN>
            </Id>
        </DbtrAcct>
        <DbtrAgt>
            <FinInstnId>
                <BIC>{{TrDbtrBIC}}</BIC>
            </FinInstnId>
        </DbtrAgt>
        <CdtTrfTxInf>
            <PmtId>
                <InstrId>{{PayRef}}</InstrId>
                <EndToEndId>{{PayRef}}</EndToEndId>
            </PmtId>
            <Amt>
                <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
            </Amt>
            <Cdtr>
                {{#ifCompare CdtrNm "!=" ""}}
                <Nm>{{CdtrNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
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
            <RmtInf>
                {{#ifCompare KID "!=" ""}}
                <Strd>
                <CdtrRefInf>
                    <Tp>
                    <CdOrPrtry>
                        <Cd>SCOR</Cd>
                    </CdOrPrtry>
                    </Tp>
                    <Ref>{{KID}}</Ref>
                </CdtrRefInf>
                </Strd>
                {{else}}
                {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{trandetails.Ref}} - Credit: {{BillCreditRef}}</Ustrd>
                {{/each}}
                {{else}}
                <Ustrd>{{Ref}}</Ustrd>
                {{/ifCompare}}
                {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{#ifCompare PayTypeNO "==" "International IBAN"}}
    {{#ifCompare BillCurrency "==" "EUR"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId>
        <PmtMtd>TRF</PmtMtd>
        <PmtTpInf>
            <SvcLvl>
                <Cd>SEPA</Cd>
            </SvcLvl>
            <CtgyPurp>
                <Cd>SUPP</Cd>
            </CtgyPurp>
        </PmtTpInf>
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        <Dbtr>
            <Nm>{{TrDbtrNm}}</Nm>
            <CtryOfRes>{{getCountryCode TrDbtrCtry}}</CtryOfRes>
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
                <InstrId>{{PayRef}}</InstrId>
                <EndToEndId>{{PayRef}}</EndToEndId>
            </PmtId>
            <Amt>
                <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
            </Amt>
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                </FinInstnId>
            </CdtrAgt>
            <Cdtr>
                {{#ifCompare CdtrNm "!=" ""}}
                <Nm>{{CdtrNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare CdtrAddr "!=" ""}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{else}}
                    <StrtNm>{{TrDbtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrZip "!=" ""}}
                    <PstCd>{{CdtrZip}}</PstCd>
                    {{else}}
                    <PstCd>{{TrDbtrZip}}</PstCd>
                    {{/ifCompare}}
                    {{#ifCompare CdtrCity "!=" ""}}
                    <TwnNm>{{CdtrCity}}</TwnNm>
                    {{else}}
                    <TwnNm>{{TrDbtrCity}}</TwnNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrBankCtry "!=" ""}}
                    <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    {{/ifCompare}}
                </PstlAdr>
            </Cdtr>
            <CdtrAcct>
                <Id>
                    <IBAN>{{CdtrIBAN}}</IBAN>
                </Id>
            </CdtrAcct>
            {{#ifCompare CdtrReportingCdNO "!=" ""}}
            <RgltryRptg>
                <Dtls>
                <Cd>14</Cd>
                <Inf>Purchase, sale of goods</Inf>
                </Dtls>
            </RgltryRptg>
            {{/ifCompare}}
            <RmtInf>                
                {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{trandetails.Ref}} - Credit: {{BillCreditRef}}</Ustrd>
                {{/each}}
                {{else}}
                <Ustrd>{{Ref}}</Ustrd>
                {{/ifCompare}}               
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{/ifCompare}}
    {{#ifCompare PayTypeNO "==" "International IBAN"}}
    {{#ifCompare BillCurrency "!=" "EUR"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
	    <PmtTpInf>
            <SvcLvl>
                <Cd>NURG</Cd>
            </SvcLvl>
            <CtgyPurp>
                <Cd>SUPP</Cd>
            </CtgyPurp>
        </PmtTpInf>
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        <Dbtr>
            <Nm>{{TrDbtrNm}}</Nm>
            <CtryOfRes>{{getCountryCode TrDbtrCtry}}</CtryOfRes>
        </Dbtr>
        <DbtrAcct>
            <Id>
                <IBAN>{{TrDbtrIBAN}}</IBAN>
            </Id>
        </DbtrAcct>
        <DbtrAgt>
            <FinInstnId>
                <BIC>{{TrDbtrBIC}}</BIC>
            </FinInstnId>
        </DbtrAgt>
        <CdtTrfTxInf>
            <PmtId>
                <InstrId>{{PayRef}}</InstrId>
                <EndToEndId>{{PayRef}}</EndToEndId>
            </PmtId>
            <Amt>
                <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
            </Amt>
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                </FinInstnId>
            </CdtrAgt>
            <Cdtr>
                {{#ifCompare CdtrNm "!=" ""}}
                <Nm>{{CdtrNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare CdtrAddr "!=" ""}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{else}}
                    <StrtNm>{{TrDbtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrZip "!=" ""}}
                    <PstCd>{{CdtrZip}}</PstCd>
                    {{else}}
                    <PstCd>{{TrDbtrZip}}</PstCd>
                    {{/ifCompare}}
                    {{#ifCompare CdtrCity "!=" ""}}
                    <TwnNm>{{CdtrCity}}</TwnNm>
                    {{else}}
                    <TwnNm>{{TrDbtrCity}}</TwnNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrBankCtry "!=" ""}}
                    <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    {{/ifCompare}}
                </PstlAdr>
            </Cdtr>
            <CdtrAcct>
                <Id>
                    <IBAN>{{CdtrIBAN}}</IBAN>
                </Id>
            </CdtrAcct>
            {{#ifCompare CdtrReportingCdNO "!=" ""}}
            <RgltryRptg>
                <Dtls>
                <Cd>14</Cd>
                <Inf>Purchase, sale of goods</Inf>
                </Dtls>
            </RgltryRptg>
            {{/ifCompare}}
            <RmtInf>
                {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{trandetails.Ref}} - Credit: {{BillCreditRef}}</Ustrd>
                {{/each}}
                {{else}}
                <Ustrd>{{Ref}}</Ustrd>
                {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{/ifCompare}}
    {{#ifCompare PayTypeNO "==" "International NON IBAN"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <PmtTpInf>
                <SvcLvl>
                    <Cd>NURG</Cd>
                </SvcLvl>
                <CtgyPurp>
                    <Cd>SUPP</Cd>
                </CtgyPurp>
        </PmtTpInf>
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") "<" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat "" "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        {{#ifCompare (dateFormat ReqdExctnDt "YYYYMMDD") ">=" (dateFormat "" "YYYYMMDD")}}
        <ReqdExctnDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"  }}</ReqdExctnDt>
        {{/ifCompare}}
        <Dbtr>
            <Nm>{{TrDbtrNm}}</Nm>
            <CtryOfRes>{{getCountryCode TrDbtrCtry}}</CtryOfRes>
        </Dbtr>
        <DbtrAcct>
            <Id>
                <Othr>
                    <Id>{{CdtrAccount}}</Id>
                    <SchmeNm>
                        <Cd>BBAN</Cd>
                    </SchmeNm>
                </Othr>
            </Id>
        </DbtrAcct>
        <DbtrAgt>
            <FinInstnId>
                <BIC>{{TrDbtrBIC}}</BIC>
            </FinInstnId>
        </DbtrAgt>
        {{#ifCompare BillCurrency "==" "USD"}}
        <ChrgBr>DEBT</ChrgBr>
        {{else}}
        <ChrgBr>SHAR</ChrgBr>
        {{/ifCompare}}
        <CdtTrfTxInf>
            <PmtId>
                <InstrId>{{PayRef}}</InstrId>
                <EndToEndId>{{PayRef}}</EndToEndId>
            </PmtId>
            <Amt>
                <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
            </Amt>
            {{#ifCompare BillCurrency "==" "USD"}}
			<CdtrAgt>
				<FinInstnId>
					<BIC>{{CdtrBIC}}</BIC>
				</FinInstnId>
			</CdtrAgt>
			{{else}}
			<CdtrAgt>
				<FinInstnId>
				<ClrSysMmbId>
				<ClrSysId>
				<Cd>USABA</Cd>
				</ClrSysId>
				<MmbId>{{CdtrBankCode}}</MmbId>
				</ClrSysMmbId>
				</FinInstnId>
			</CdtrAgt>
            {{/ifCompare}}
            <Cdtr>
                {{#ifCompare CdtrNm "!=" ""}}
                <Nm>{{CdtrNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare CdtrBankStreet "!=" ""}}
                    <StrtNm>{{CdtrBankStreet}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrBankZip "!=" ""}}
                    <PstCd>{{CdtrBankZip}}</PstCd>
                    {{/ifCompare}}
                    {{#ifCompare CdtrBankCity "!=" ""}}
                    <TwnNm>{{CdtrBankCity}}</TwnNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrBankCtry "!=" ""}}
                    <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    {{/ifCompare}}
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
            {{#ifCompare CdtrReportingCdNO "!=" ""}}
            <RgltryRptg>
                <Dtls>
                <Cd>14</Cd>
                <Inf>Purchase, sale of goods</Inf>
                </Dtls>
            </RgltryRptg>
            {{/ifCompare}}
            <RmtInf>
                {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{trandetails.Ref}} - Credit: {{BillCreditRef}}</Ustrd>
                {{/each}}
                {{else}}
                <Ustrd>{{Ref}}</Ustrd>
                {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{/each}}    
</CstmrCdtTrfInitn>
</Document>