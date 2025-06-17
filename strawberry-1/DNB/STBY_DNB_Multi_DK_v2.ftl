<?xml version="1.0" encoding="UTF-8"?>
<Document xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03 pain.001.001.03.xsd">
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
                    <Othr>
                        <Id>{{companybank.Division}}</Id>
                        <SchmeNm>
                            <Cd>BANK</Cd>
                        </SchmeNm>
                    </Othr>
                </OrgId>
            </Id>
        </InitgPty>
    </GrpHdr>
    {{#each trandetails}}    
    {{#ifCompare PayTypeDK "==" "Domestic"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId>
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
                <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
            </PstlAdr>
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
            {{#ifCompare LocPayType "==" "FI Card 71"}}
			<PmtTpInf>
				<SvcLvl>
					<Prtry>IBK71</Prtry>
				</SvcLvl>
			</PmtTpInf>
            {{/ifCompare}}
			{{#ifCompare LocPayType "==" "FI Card 73"}}
			<PmtTpInf>
				<SvcLvl>
					<Prtry>IBK73</Prtry>
				</SvcLvl>
			</PmtTpInf>
            {{/ifCompare}}
            {{#ifCompare LocPayType "==" "FI Card 75"}}
			<PmtTpInf>
				<SvcLvl>
					<Prtry>IBK75</Prtry>
				</SvcLvl>
			</PmtTpInf>
            {{/ifCompare}}
			{{#ifCompare LocPayType "==" "GiroCard 01"}}
			<PmtTpInf>
				<SvcLvl>
					<Prtry>IBK01</Prtry>
				</SvcLvl>
			</PmtTpInf>
            {{/ifCompare}}
			{{#ifCompare LocPayType "==" "GiroCard 04"}}
			<PmtTpInf>
				<SvcLvl>
					<Prtry>IBK04</Prtry>
				</SvcLvl>
			</PmtTpInf>
            {{/ifCompare}}
            <Amt>
                <InstdAmt Ccy="{{BillCurrency}}">{{BillAmount}}</InstdAmt>
            </Amt>
            <Cdtr>
                {{#ifCompare EmpNm "!=" ""}}
                <Nm>{{EmpNm}}</Nm>
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
            {{#ifCompare LocPayType "==" "FI Card 71"}}
                {{#ifCompare KID "!=" ""}}
                <Strd>
                    <RfrdDocInf>
                        <Tp>
                            <CdOrPrtry>
                                <Cd>CINV</Cd>
                            </CdOrPrtry>
                        </Tp>
                        <RltdDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"}}</RltdDt>
                    </RfrdDocInf>
                    <RfrdDocAmt>
                        <RmtdAmt Ccy="{{BillCurrency}}">{{BillOrgAmount}}</RmtdAmt>
                    </RfrdDocAmt>
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
                <Strd>
                    <RfrdDocInf>
                        <Tp>
                            <CdOrPrtry>
                                <Cd>CINV</Cd>
                            </CdOrPrtry>
                        </Tp>
                        <RltdDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"}}</RltdDt>
                    </RfrdDocInf>
                    <RfrdDocAmt>
                        <RmtdAmt Ccy="{{BillCurrency}}">{{BillOrgAmount}}</RmtdAmt>
                    </RfrdDocAmt>
                    <CdtrRefInf>
                    <Tp>
                        <CdOrPrtry>
                            <Cd>SCOR</Cd>
                        </CdOrPrtry>
                    </Tp>
                    <Ref>{{Ref}}</Ref>
                    </CdtrRefInf>
                </Strd>
                {{/ifCompare}}
            {{/ifCompare}}
            {{#ifCompare LocPayType "==" "FI Card 73"}}
                {{#ifCompare KID "!=" ""}}
                    {{#ifCompare billcreditdetails "!=" ""}}
                    {{#each billcreditdetails}} 
                    <Ustrd>{{KID}} - Credit: {{BillCreditRef}}</Ustrd>
                    {{else}}
                    <Ustrd>{{KID}}</Ustrd>
                    {{/each}}
                    {{/ifCompare}}
                {{/ifCompare}}
                {{#ifCompare KID "==" ""}}
                    {{#ifCompare billcreditdetails "!=" ""}}
                    {{#each billcreditdetails}} 
                    <Ustrd>{{Ref}} - Credit: {{BillCreditRef}}</Ustrd>
                    {{else}}
                    <Ustrd>{{Ref}}</Ustrd>
                    {{/each}}
                    {{/ifCompare}}
                {{/ifCompare}}
            {{/ifCompare}}
            {{#ifCompare LocPayType "==" "FI Card 75"}}
                {{#ifCompare KID "!=" ""}}
                    {{#ifCompare billcreditdetails "!=" ""}}
                    {{#each billcreditdetails}} 
                    <Ustrd>{{KID}} - Credit: {{BillCreditRef}}</Ustrd>
                    {{else}}
                    <Ustrd>{{KID}}</Ustrd>
                    {{/each}}
                    {{/ifCompare}}
                {{/ifCompare}}
                {{#ifCompare KID "==" ""}}
                    {{#ifCompare billcreditdetails "!=" ""}}
                    {{#each billcreditdetails}} 
                    <Ustrd>{{Ref}} - Credit: {{BillCreditRef}}</Ustrd>
                    {{else}}
                    <Ustrd>{{Ref}}</Ustrd>
                    {{/each}}
                    {{/ifCompare}}
                {{/ifCompare}}
                {{#ifCompare KID "!=" ""}}
                <Strd>
                    <RfrdDocInf>
                        <Tp>
                            <CdOrPrtry>
                                <Cd>CINV</Cd>
                            </CdOrPrtry>
                        </Tp>
                        <RltdDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"}}</RltdDt>
                    </RfrdDocInf>
                    <RfrdDocAmt>
                        <RmtdAmt Ccy="{{BillCurrency}}">{{BillOrgAmount}}</RmtdAmt>
                    </RfrdDocAmt>
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
                <Strd>
                    <RfrdDocInf>
                        <Tp>
                            <CdOrPrtry>
                                <Cd>CINV</Cd>
                            </CdOrPrtry>
                        </Tp>
                        <RltdDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"}}</RltdDt>
                    </RfrdDocInf>
                    <RfrdDocAmt>
                        <RmtdAmt Ccy="{{BillCurrency}}">{{BillOrgAmount}}</RmtdAmt>
                    </RfrdDocAmt>
                    <CdtrRefInf>
                    <Tp>
                        <CdOrPrtry>
                            <Cd>SCOR</Cd>
                        </CdOrPrtry>
                    </Tp>
                    <Ref>{{Ref}}</Ref>
                    </CdtrRefInf>
                </Strd>
                {{/ifCompare}}
            {{/ifCompare}}    
            {{#ifCompare LocPayType "==" "GiroCard 01"}}
                {{#ifCompare KID "!=" ""}}
                    {{#ifCompare billcreditdetails "!=" ""}}
                    {{#each billcreditdetails}} 
                    <Ustrd>{{KID}} - Credit: {{BillCreditRef}}</Ustrd>
                    {{else}}
                    <Ustrd>{{KID}}</Ustrd>
                    {{/each}}
                    {{/ifCompare}}
                {{/ifCompare}}
                {{#ifCompare KID "==" ""}}
                    {{#ifCompare billcreditdetails "!=" ""}}
                    {{#each billcreditdetails}} 
                    <Ustrd>{{Ref}} - Credit: {{BillCreditRef}}</Ustrd>
                    {{else}}
                    <Ustrd>{{Ref}}</Ustrd>
                    {{/each}}
                    {{/ifCompare}}
                {{/ifCompare}}
            {{/ifCompare}}    
            {{#ifCompare LocPayType "==" "GiroCard 04"}}
                {{#ifCompare KID "!=" ""}}
                <Strd>
                    <RfrdDocInf>
                        <Tp>
                            <CdOrPrtry>
                                <Cd>CINV</Cd>
                            </CdOrPrtry>
                        </Tp>
                        <RltdDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"}}</RltdDt>
                    </RfrdDocInf>
                    <RfrdDocAmt>
                        <RmtdAmt Ccy="{{BillCurrency}}">{{BillOrgAmount}}</RmtdAmt>
                    </RfrdDocAmt>
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
                <Strd>
                    <RfrdDocInf>
                        <Tp>
                            <CdOrPrtry>
                                <Cd>CINV</Cd>
                            </CdOrPrtry>
                        </Tp>
                        <RltdDt>{{dateFormat ReqdExctnDt "YYYY-MM-DD"}}</RltdDt>
                    </RfrdDocInf>
                    <RfrdDocAmt>
                        <RmtdAmt Ccy="{{BillCurrency}}">{{BillOrgAmount}}</RmtdAmt>
                    </RfrdDocAmt>
                    <CdtrRefInf>
                    <Tp>
                        <CdOrPrtry>
                            <Cd>SCOR</Cd>
                        </CdOrPrtry>
                    </Tp>
                    <Ref>{{Ref}}</Ref>
                    </CdtrRefInf>
                </Strd>
                {{/ifCompare}}
            {{/ifCompare}}
            {{#ifCompare LocPayType "==" ""}}
                {{#ifCompare KID "!=" ""}}
                    {{#ifCompare billcreditdetails "!=" ""}}
                    {{#each billcreditdetails}} 
                    <Ustrd>{{KID}} - Credit: {{BillCreditRef}}</Ustrd>
                    {{else}}
                    <Ustrd>{{KID}}</Ustrd>
                    {{/each}}
                    {{/ifCompare}}
                {{/ifCompare}}
                {{#ifCompare KID "==" ""}}
                    {{#ifCompare billcreditdetails "!=" ""}}
                    {{#each billcreditdetails}} 
                    <Ustrd>{{Ref}} - Credit: {{BillCreditRef}}</Ustrd>
                    {{else}}
                    <Ustrd>{{Ref}}</Ustrd>
                    {{/each}}
                    {{/ifCompare}}
                {{/ifCompare}}
            {{/ifCompare}}
            {{#ifCompare LocPayType "==" "N/A"}}
                {{#ifCompare KID "!=" ""}}
                    {{#ifCompare billcreditdetails "!=" ""}}
                    {{#each billcreditdetails}} 
                    <Ustrd>{{KID}} - Credit: {{BillCreditRef}}</Ustrd>
                    {{else}}
                    <Ustrd>{{KID}}</Ustrd>
                    {{/each}}
                    {{/ifCompare}}
                {{/ifCompare}}
                {{#ifCompare KID "==" ""}}
                    {{#ifCompare billcreditdetails "!=" ""}}
                    {{#each billcreditdetails}} 
                    <Ustrd>{{Ref}} - Credit: {{BillCreditRef}}</Ustrd>
                    {{else}}
                    <Ustrd>{{Ref}}</Ustrd>
                    {{/each}}
                    {{/ifCompare}}
                {{/ifCompare}}
            {{/ifCompare}}
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{#ifCompare PayTypeDK "==" "International IBAN"}}
    {{#ifCompare BillCurrency "==" "EUR"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId>
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
        <NbOfTxs>1</NbOfTxs>
        <CtrlSum>{{BillAmount}}</CtrlSum>
        <PmtTpInf>
            <SvcLvl>
                <Cd>SEPA</Cd>
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
            <PstlAdr>
                <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
            </PstlAdr>
            <Id>
                <OrgId>
                    <Othr>
                        <Id>{{TrDbtrOrg}}</Id>
                        <SchmeNm>
                            <Cd>CUST</Cd>
                        </SchmeNm>
                    </Othr>
                    <Othr>
                        <Id>{{TrDbtrDiv}}</Id>
                        <SchmeNm>
                            <Cd>BANK</Cd>
                        </SchmeNm>
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
                {{#ifCompare EmpNm "!=" ""}}
                <Nm>{{EmpNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare EmpAddr "!=" ""}}
                    <StrtNm>{{EmpAddr}}</StrtNm>
                    {{else}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare EmpZip "!=" ""}}
                    <PstCd>{{EmpZip}}</PstCd>
                    {{else}}
                    <PstCd>{{CdtrZip}}</PstCd>                      
                    {{/ifCompare}}
                    {{#ifCompare EmpCity "!=" ""}}
                    <TwnNm>{{EmpCity}}</TwnNm>
                    {{else}}
                    <TwnNm>{{CdtrCity}}</TwnNm>
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
            <Purp>
                <Cd>SUPP</Cd>
            </Purp>
            <RmtInf>                
                <Ustrd>{{Ref}}</Ustrd>                  
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{/ifCompare}}
    {{#ifCompare PayTypeDK "==" "International IBAN"}}
    {{#ifCompare BillCurrency "!=" "EUR"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
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
                <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
            </PstlAdr>
            <Id>
                <OrgId>
                    <Othr>
                        <Id>{{TrDbtrOrg}}</Id>
                        <SchmeNm>
                            <Cd>CUST</Cd>
                        </SchmeNm>
                    </Othr>
                    <Othr>
                        <Id>{{TrDbtrDiv}}</Id>
                        <SchmeNm>
                            <Cd>BANK</Cd>
                        </SchmeNm>
                    </Othr>
                </OrgId>
            </Id>
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
                {{#ifCompare EmpNm "!=" ""}}
                <Nm>{{EmpNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare EmpAddr "!=" ""}}
                    <StrtNm>{{EmpAddr}}</StrtNm>
                    {{else}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare EmpZip "!=" ""}}
                    <PstCd>{{EmpZip}}</PstCd>
                    {{else}}
                    <PstCd>{{CdtrZip}}</PstCd>                      
                    {{/ifCompare}}
                    {{#ifCompare EmpCity "!=" ""}}
                    <TwnNm>{{EmpCity}}</TwnNm>
                    {{else}}
                    <TwnNm>{{CdtrCity}}</TwnNm>
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
            <RmtInf>                
                <Ustrd>{{Ref}}</Ustrd>                  
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{/ifCompare}}
    {{#ifCompare PayTypeDK "==" "International NON IBAN"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
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
                <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
            </PstlAdr>
            <Id>
                <OrgId>
                    <Othr>
                        <Id>{{TrDbtrOrg}}</Id>
                        <SchmeNm>
                            <Cd>CUST</Cd>
                        </SchmeNm>
                    </Othr>
                    <Othr>
                        <Id>{{TrDbtrDiv}}</Id>
                        <SchmeNm>
                            <Cd>BANK</Cd>
                        </SchmeNm>
                    </Othr>
                </OrgId>
            </Id>
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
            {{#ifCompare CdtrBankCode "!=" ""}}
            <CdtrAgt>
                <FinInstnId>
                    <BIC>{{CdtrBIC}}</BIC>
                </FinInstnId>
            </CdtrAgt>
            {{/ifCompare}}
            {{#ifCompare CdtrBIC "!=" ""}}
            <CdtrAgt>
                <FinInstnId>
                    <ClrSysMmbId>
                        <ClrSysId>
                            <Cd>{{CdtrClearing}}</Cd>
                        </ClrSysId>
                        <MmbId>{{CdtrBankCode}}</MmbId>
                    </ClrSysMmbId>
                    <PstlAdr>
                        <Ctry>{{getCountryCode CdtrBankCtry}}</Ctry>
                    </PstlAdr>
                </FinInstnId>
            </CdtrAgt>
            {{/ifCompare}}
            <Cdtr>
                {{#ifCompare EmpNm "!=" ""}}
                <Nm>{{EmpNm}}</Nm>
                {{else}}
                <Nm>{{Cdtr}}</Nm>
                {{/ifCompare}}
                <PstlAdr>
                    {{#ifCompare EmpAddr "!=" ""}}
                    <StrtNm>{{EmpAddr}}</StrtNm>
                    {{else}}
                    <StrtNm>{{CdtrAddr}}</StrtNm>
                    {{/ifCompare}}
                    {{#ifCompare EmpZip "!=" ""}}
                    <PstCd>{{EmpZip}}</PstCd>
                    {{else}}
                    <PstCd>{{CdtrZip}}</PstCd>                      
                    {{/ifCompare}}
                    {{#ifCompare EmpCity "!=" ""}}
                    <TwnNm>{{EmpCity}}</TwnNm>
                    {{else}}
                    <TwnNm>{{CdtrCity}}</TwnNm>
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
            <RmtInf>
                <Ustrd>{{Ref}}</Ustrd>
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{#ifCompare PayTypeDK "==" "Intracompany"}}
    <PmtInf>
        <PmtInfId>{{PayRef}}</PmtInfId> 
        <PmtMtd>TRF</PmtMtd>
        <BtchBookg>false</BtchBookg>
        <CtrlSum>{{BillAmount}}</CtrlSum>
        <PmtTpInf>
            <CtgyPurp>
                <Cd>INTC</Cd>
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
            <PstlAdr>
                <Ctry>{{getCountryCode TrDbtrCtry}}</Ctry>
            </PstlAdr>
        </Dbtr>
        <DbtrAcct>
            <Id>
                <IBAN>{{TrDbtrIBAN}}</IBAN>
            </Id>
            <Ccy>{{DbtrCcy}}</Ccy>
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
                {{#ifCompare EmpNm "!=" ""}}
                <Nm>{{EmpNm}}</Nm>
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
                <Ustrd>{{Ref}}</Ustrd>
            </RmtInf>
        </CdtTrfTxInf>
    </PmtInf>
    {{/ifCompare}}
    {{/each}}    
</CstmrCdtTrfInitn>
</Document>