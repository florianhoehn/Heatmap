public with sharing class HeatmapDemoController {

  public class CountryInfo {
    public String name { get; set; }
    public Decimal latitude { get; set; }
    public Decimal longitude { get; set; }
    public Integer count { get; set; }

    public CountryInfo() {
      this.count = 0;
    }
  }

  public Map<String, CountryInfo> countryMap { get; set; }

  public HeatmapDemoController() {
    this.countryMap = new Map<String, CountryInfo>();
    for(Opportunity student : [SELECT Account.Country_Name__c,
                                      Account.main_adr_country__r.Geolocation__Latitude__s,
                                      Account.main_adr_country__r.Geolocation__Longitude__s
                                 FROM Opportunity
                                WHERE CreatedDate > 2014-06-01T00:00:00.000Z
                                  AND Account.Country_Name__c != null
                                  AND School__c = 'a0J20000007prlY'
                                  AND Account.main_adr_country__r.Geolocation__Latitude__s != null
                             ORDER BY Account.Country_Name__c]) {
      CountryInfo info = new CountryInfo();
      if((info = countryMap.get(student.Account.Country_Name__c)) == null) {
        info = new CountryInfo();
        info.name = student.Account.Country_Name__c;
        info.latitude = student.Account.main_adr_country__r.Geolocation__Latitude__s;
        info.longitude = student.Account.main_adr_country__r.Geolocation__Longitude__s;
        this.countryMap.put(student.Account.Country_Name__c, info);
      }
      info.count++;
    }
  }
}