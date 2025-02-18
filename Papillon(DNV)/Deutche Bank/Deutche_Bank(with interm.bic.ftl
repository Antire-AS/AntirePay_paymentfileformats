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
            </FinInstnId>
            <PstlAdr>
				<Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
			</PstlAdr>
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
            {{#ifCompare <!-- "this field" --> "!=" ""}}
            <IntrmyAgt1>
                <FinInstnId>
                    <BIC><!-- Here should be a field, that represents Intermediary Bank BIC/SWIFT code on the Vendor(Entity) side--></BIC>
                </FinInstnId>
            </IntrmyAgt1>
            {{/ifCompare}}
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
            {{#ifCompare CdtrReportingCdNO<!-- List should be renamed to Deutche Bank Reporting Codes? --> "!=" ""}}
            <RgltryRptg>
                <Authrty>
                    <Ctry>{{getCountryCode CdtrCtry}}</Ctry>
                </Authrty>
                <Dtls>
                    <Cd><!-- Code List field should be provided (p. 135-136 EMEA International Credit Transfer) --></Cd>
                    <Inf><!-- Information List field should be provided (not sure if it is mandatory for Germany) (p. 136 EMEA International Credit Transfer) --></Inf>
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
    {{#ifCompare PayType "==" "International IBAN"}}
    {{#ifCompare BillCurrency "!=" "EUR"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId>
        <PmtMtd>TRF</PmtMtd>
	    <PmtTpInf>
            <SvcLvl>
                <Cd>NURG</Cd>
            </SvcLvl>
            <CtgyPurp>
                <Cd><!-- Here should be List with the Category Purpose Codes from the Implementation guide document (p. 163-164 EMEA International Credit Transfer)--></Cd>
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
            <PstlAdr>
				<Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
			</PstlAdr>
        </DbtrAgt>
        <ChrgBr><!-- Here should be List with the Charge Codes from the Implementation guide document (DEBT, CRED or SHAR) (p. 102-103 EMEA International Credit Transfer)--></ChrgBr>
        <CdtTrfTxInf>
            <PmtId>
                <InstrId>{{PayRef}}</InstrId>
                <EndToEndId>{{PayRef}}</EndToEndId>
            </PmtId>
            <Amt>
                <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
            </Amt>
            {{#ifCompare <!-- "this field" --> "!=" ""}}
            <IntrmyAgt1>
                <FinInstnId>
                    <BIC><!-- Here should be a field, that represents Intermediary Bank BIC/SWIFT code on the Vendor(Entity) side--></BIC>
                </FinInstnId>
            </IntrmyAgt1>
            {{/ifCompare}}
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
            {{#ifCompare CdtrReportingCdNO<!-- List should be renamed to Deutche Bank Reporting Codes? --> "!=" ""}}
            <RgltryRptg>
                <Authrty>
                    <Ctry>{{getCountryCode CdtrCtry}}</Ctry>
                </Authrty>
                <Dtls>
                    <Cd><!-- Code List field should be provided (p. 135-136 EMEA International Credit Transfer) --></Cd>
                    <Inf><!-- Information List field should be provided (not sure if it is mandatory for Germany) (p. 136 EMEA International Credit Transfer) --></Inf>
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
    {{#ifCompare PayType "==" "International NON IBAN"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <PmtTpInf>
            <SvcLvl>
                <Cd>NURG</Cd>
            </SvcLvl>
            <CtgyPurp>
                <Cd><!-- Here should be List with the Category Purpose Codes from the Implementation guide document (p. 163-164 EMEA International Credit Transfer)--></Cd>
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
                    <Id>{{CdtrAccount}}<!-- It was here before, should not it be TrDbtrBBAN? Let you decide.--></Id>
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
            </FinInstnId>
        </DbtrAgt>
        <ChrgBr><!-- Here should be List with the Charge Codes from the Implementation guide document (DEBT, CRED or SHAR) (p. 102-103 EMEA International Credit Transfer)--></ChrgBr>
        <CdtTrfTxInf>
            <PmtId>
                <InstrId>{{PayRef}}</InstrId>
                <EndToEndId>{{PayRef}}</EndToEndId>
            </PmtId>
            <Amt>
                <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
            </Amt>
            {{#ifCompare <!-- "this field" --> "!=" ""}}
            <IntrmyAgt1>
                <FinInstnId>
                    <BIC><!-- Here should be a field, that represents Intermediary Bank BIC/SWIFT code on the Vendor(Entity) side--></BIC>
                </FinInstnId>
            </IntrmyAgt1>
            {{/ifCompare}}
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
				            <Cd>USABA<!-- Should by dynamic, p. 29 EMEA International Credit Transfer. Not a list, but just a field. CdtrClearing? --></Cd>
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
                    <SchmeNm>
                        <Cd>BBAN</Cd>
                    </SchmeNm>
                    </Othr>
                </Id>
            </CdtrAcct>
            {{#ifCompare CdtrReportingCdNO<!-- List should be renamed to Deutche Bank Reporting Codes? --> "!=" ""}}
            <RgltryRptg>
                <Authrty>
                    <Ctry>{{getCountryCode CdtrCtry}}</Ctry>
                </Authrty>
                <Dtls>
                    <Cd><!-- Code List field should be provided (p. 135-136 EMEA International Credit Transfer) --></Cd>
                    <Inf><!-- Information List field should be provided (not sure if it is mandatory for Germany) (p. 136 EMEA International Credit Transfer) --></Inf>
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