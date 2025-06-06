<?xml version="1.0" encoding="utf-8"?>
<Document xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
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
        <PmtInfId>{{PayRef}}</PmtInfId>
        <PmtMtd>TRF</PmtMtd>
        <PmtTpInf>
            <SvcLvl>
                <Prtry>URGP</Prtry>
            </SvcLvl>
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
                <PstlAdr>
                    <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
                </PstlAdr>
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
                {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{Ref}} - Credit: {{BillCrRef}}</Ustrd>
                {{/each}}
                <Ustrd>{{Ref}}</Ustrd>
                {{else}}
                {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{#ifCompare PayType "==" "International IBAN"}}
    {{#ifCompare BillCurrency "==" "EUR"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId>
        <PmtMtd>TRF</PmtMtd>
        <PmtTpInf>
            <SvcLvl>
                <Cd>NURG</Cd>
            </SvcLvl>
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
                <PstlAdr>
                    <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
                </PstlAdr>
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
                    {{#ifCompare CdtrCtry "!=" ""}}
                    <Ctry>{{getCountryCode CdtrCtry}}</Ctry>
                    {{/ifCompare}}
                </PstlAdr>
            </Cdtr>
            <CdtrAcct>
                <Id>
                    <IBAN>{{CdtrIBAN}}</IBAN>
                </Id>
            </CdtrAcct>
            <RmtInf>
                {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{Ref}} - Credit: {{BillCrRef}}</Ustrd>
                {{/each}}
                <Ustrd>{{Ref}}</Ustrd>
                {{else}}
                {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{/ifCompare}}
    {{#ifCompare PayType "==" "International IBAN"}}
    {{#ifCompare BillCurrency "!=" "EUR"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId>
        <PmtMtd>TRF</PmtMtd>
	    <PmtTpInf>
            <SvcLvl>
                <Cd>NURG</Cd>
            </SvcLvl>
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
                <PstlAdr>
                    <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
                </PstlAdr>
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
                    {{#ifCompare CdtrCtry "!=" ""}}
                    <Ctry>{{getCountryCode CdtrCtry}}</Ctry>
                    {{/ifCompare}}
                </PstlAdr>
            </Cdtr>
            <CdtrAcct>
                <Id>
                    <IBAN>{{CdtrIBAN}}</IBAN>
                </Id>
            </CdtrAcct>
            <RmtInf>
                {{#ifCompare billcreditdetails "!=" ""}}
                {{#each billcreditdetails}} 
                <Ustrd>{{Ref}} - Credit: {{BillCrRef}}</Ustrd>
                {{/each}}
                <Ustrd>{{Ref}}</Ustrd>
                {{else}}
                {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{/ifCompare}}
    {{#ifCompare PayType "==" "International NON IBAN"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <PmtTpInf>
            <SvcLvl>
                <Cd>NURG</Cd>
            </SvcLvl>
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
                    <Id>{{TrDbtrIBAN}}</Id>
                    <SchmeNm>
                        <Cd>BBAN</Cd>
                    </SchmeNm>
                </Othr>
            </Id>
            <Ccy>{{TrDbtrCur}}</Ccy>
        </DbtrAcct>
        <DbtrAgt>
            <FinInstnId>
                <BIC>{{TrDbtrBIC}}</BIC>
                <PstlAdr>
                    <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
                </PstlAdr>
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
            {{#ifCompare CdtrBankCode "==" ""}}
			<CdtrAgt>
				<FinInstnId>
					<BIC>{{CdtrBIC}}</BIC>
				</FinInstnId>
			</CdtrAgt>
            {{/ifCompare}}
            {{#ifCompare CdtrBankCode "!=" ""}}
			<CdtrAgt>
				<FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
				    <ClrSysMmbId>
				        <ClrSysId>
				            <Cd>{{CdtrClearing}}</Cd>
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
                    {{#ifCompare CdtrAddr "!=" ""}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrZip "!=" ""}}
                    <PstCd>{{CdtrZip}}</PstCd>
                    {{/ifCompare}}
                    {{#ifCompare CdtrCity "!=" ""}}
                    <TwnNm>{{CdtrCity}}</TwnNm>
                    {{/ifCompare}}
                    {{#ifCompare CdtrCtry "!=" ""}}
                    <Ctry>{{getCountryCode CdtrCtry}}</Ctry>
                    {{/ifCompare}}
                </PstlAdr>
            </Cdtr>
            <CdtrAcct>
                <Id>
                    <Othr>
                    <Id>{{CdtrAccount}}</Id>
                    </Othr>
                </Id>
            </CdtrAcct>
            <RmtInf>
                {{#ifCompare CdtrCtry "==" "China"}}
                    {{#ifCompare billcreditdetails "!=" ""}}
                    {{#each billcreditdetails}} 
                    <Ustrd>/CSTRDR/ {{Ref}} - Credit: {{BillCrRef}}</Ustrd>
                    {{/each}}
                    <Ustrd>/CSTRDR/ {{Ref}}</Ustrd>
                    {{else}}
                    {{/ifCompare}}
                {{/ifCompare}}
                {{#ifCompare CdtrCtry "!=" "China"}}
                    {{#ifCompare billcreditdetails "!=" ""}}
                    {{#each billcreditdetails}} 
                    <Ustrd>{{Ref}} - Credit: {{BillCrRef}}</Ustrd>
                    {{/each}}
                    <Ustrd>{{Ref}}</Ustrd>
                    {{else}}
                    {{/ifCompare}}
                {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{/each}}    
</CstmrCdtTrfInitn>
</Document>