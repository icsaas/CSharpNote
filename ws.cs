#web.config
<system.web>
   <webService>
     <protocols>
       <add name="HttpSoap"/>
       <add name="HttpPost"/>
       <add name="HttpGet"/>
       <add name="Documentation"/>
     </protocols>
    </webService>
<identity impersonate="true"  userName="accountname" password="password" />

</system.web>
