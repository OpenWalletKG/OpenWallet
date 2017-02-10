require 'rails_helper'

RSpec.describe EsbClient do
  describe '.getClient' do
    it 'should return client info' do
      response = EsbClient.getClient('1595036601')
      expect(response['client']).to eq([{
        'typeClient' => '2',
        'clientId' => '1595036601',
        'IN' => '890507302284',
        'Name' => 'Джантуреев Даулетбек Морбекович',
        'firstName' => 'Даулетбек',
        'surName' => 'Джантуреев (Stub)',
        'middleName' => 'Морбекович',
        'birthDate' => '1989-05-07T00:00:00',
        'Citizenship' => 'KAZ',
        'Gender' => 'М',
        'famStatus' => nil,
        'Okved' => nil,
        'codeOkpo' => nil,
        'Sector' => nil,
        'faseID' => nil,
        'faseName' => nil,
        'Range' => nil,
        'legalForm' => nil,
        'registrationNumber' => nil,
        'registrationDate' => nil
        }])
    end
  end

  describe '.findClient' do
    it 'should return clientId' do
      response = EsbClient.findClient('030540008197', '1')
      expect(response['clientId']).to eq('1602991289')
    end
  end

  describe '.findAccount' do
    it 'should return accountId' do
      response = EsbClient.findAccount('KZ026200818600000031', '1597737773')
      expect(response['accountId']).to eq('1597753309')
    end
  end

  describe '.getAccountSaldo' do
    it 'should return account saldo' do
      response = EsbClient.getAccountSaldo('1597753309')
      expect(response['Saldo']).to eq('34500.65')
      expect(response['SaldoNat']).to eq('34500.65')
      expect(response['SaldoBlock']).to eq('0')
    end
  end

  describe '.getAccountStatementByPeriod' do
    it 'should return statement for chosen period' do
      response = EsbClient.getAccountStatementByPeriod('1603005784', '2016-07-02T19:00:00.000', '2017-07-02T19:00:00.000')
      expect(response['Statement'].first).to eq(
        {
          'DtCr' => 'C',
          'docDate' => '2016-10-23T17:36:06',
          'docNum' => '65168139',
          'docSum' => '187010.94',
          'docSumNat' => '187010.94',
          'inSaldo' => '0',
          'inSaldoNat' => '0',
          'outSaldo' => '187010.94',
          'outSaldoNat' => '187010.94',
          'paymDetails' => 'Служебная операция. Разнесение сумм со сводного счета'
          }     
        )
    end
  end

  describe '.getAccountStatementByLimit' do
    it 'should return statement by limit' do
      response = EsbClient.getAccountStatementByLimit('1603005784', '1')
      expect(response['Statement']).to eq([{
        'DtCr' => 'C',
        'docDate' => '2016-10-23T17:36:06',
        'docNum' => '65168139',
        'docSum' => '187010.94',
        'docSumNat' => '187010.94',
        'inSaldo' => '0',
        'inSaldoNat' => '0',
        'outSaldo' => '187010.94',
        'outSaldoNat' => '187010.94',
        'paymDetails' => 'Служебная операция. Разнесение сумм со сводного счета'
        }])
    end
  end

  describe '.findAgent' do
    it 'should return agentId' do
      response = EsbClient.findAgent('950740000130', '16585812')
      expect(response).to eq('1658704002')
    end
  end

  describe '.getAgent' do
    it 'should return clientId and agentType' do
      response = EsbClient.getAgent('1658935783')
      expect(response['clientId']).to eq('1602991289')
      expect(response['agentType']).to eq('AGENT')
    end
  end

  describe '.getAccountCalendar' do
    it 'should return list of dates on which the documents are available in the account statement' do
      response = EsbClient.getAccountCalendar('1594424934', '11', '2016')
      expect(response['Calendar']).to eq([
        {'Dt' => '2016-01-10'},
        {'Dt' => '2016-02-10'},
        {'Dt' => '2016-03-10'},
        {'Dt' => '2016-04-10'},
        {'Dt' => '2016-05-10'},
        {'Dt' => '2016-06-10'},
        {'Dt' => '2016-07-10'},
        {'Dt' => '2016-08-10'},
        {'Dt' => '2016-09-10'},
        {'Dt' => '2016-10-10'},
        {'Dt' => '2016-11-10'},
        {'Dt' => '2016-12-10'},
        ])
    end
  end 

  describe '.getStatus' do
    it 'should return status of the document' do
      response = EsbClient.getStatus('2lzpol8xqhciy4c1dp98q')
      expect(response['status']).to eq('Исполнен')
    end
  end

end