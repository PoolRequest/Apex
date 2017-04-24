global class zillowCallout {
@future(callout=true)

public static void createZillowReq(id recId) 
    {
        HttpRequest req = new HttpRequest();
        req.setHeader('Content-Type','application/json');
        Lead l = [select id, Street, City, State, PostalCode, Square_Footage__c from Lead where id =: recId];
        if (l.Street != null)
        {
            String encodeStreet = EncodingUtil.urlEncode(l.Street, 'UTF-8');
            String endpoint = 'http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz1fnt9lzm423_4lr3d&address='+encodeStreet+'&citystatezip='+l.City + l.State + l.PostalCode;
            String encode = EncodingUtil.urlEncode(endpoint, 'UTF-8');
            req.setMethod('POST');
            req.setEndpoint(endpoint); 
            //SOQL to construct JSON string in set body
            //Http response method 
            Http http = new Http();
            HTTPResponse res = http.send(req);
            parseResponse(res, l);
        }
    }
        
public static void parseResponse(HTTPResponse res, Lead l)
{
        Dom.Document doc = new Dom.Document();
        doc.load(res.getBody());
    
        Dom.XmlNode nodes = doc.getRootElement(); 
        List<Dom.XmlNode> rootList = nodes.getChildren();
        
        for (Dom.XmlNode topNode : rootList)
        {
            if (topNode.getName() == 'response')
            {
                List<Dom.XmlNode> resultsList = topNode.getChildren();
                for (Dom.XmlNode result : resultsList)
                {
                    List<Dom.XmlNode> r = result.getChildren();
                    for (Dom.XmlNode resp : r)
                    {
                        List<Dom.XmlNode> actualData = resp.getChildren();
                        for (Dom.XmlNode data : actualData)
                        {
                            if (data.getName() == 'finishedSqFt')
                            {
                                l.Square_Footage__c = data.getText();
                            }
                        }
                    }
                }
            }
        }
    update l;
      }  
}
