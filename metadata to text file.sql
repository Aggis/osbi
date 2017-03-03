
select 
      [WO_STA_Work_Start]
      ,[WO_END_Work_End]
      ,[WO_NAM_Work_Name]
      ,[WO_USR_Work_InvocationUser]
      ,[WO_ROL_Work_InvocationRole]
      ,[WO_EST_EST_ExecutionStatus]
      ,[WO_ERL_Work_ErrorLine]
      ,[WO_ERM_Work_ErrorMessage]
      ,[WO_AID_Work_AgentStepId]

      ,[JB_STA_Job_Start]
      ,[JB_END_Job_End]
      ,[JB_NAM_Job_Name]
      ,[JB_EST_EST_ExecutionStatus]
      ,[JB_AID_Job_AgentJobId]

      ,[CF_NAM_Configuration_Name]
      ,[CF_XML_Checksum]
      --,[CF_XML_Configuration_XMLDefinition]
      ,[CF_TYP_CFT_ConfigurationType]

    ,cos.[CO_NAM_Container_Name] as src_Container_Name
      ,cos.[CO_TYP_COT_ContainerType] as src_ContainerType
      ,cos.[CO_DSC_Container_Discovered] as src_Container_Discovered
      ,cos.[CO_CRE_Container_Created] as src_Container_Created
	  
	  ,cot.[CO_NAM_Container_Name] as trg_Container_Name
      ,cot.[CO_TYP_COT_ContainerType] as trg_ContainerType
      ,cot.[CO_DSC_Container_Discovered] as trg_Container_Discovered
      ,cot.[CO_CRE_Container_Created] as trg_Container_Created
	  
 from
stage.metadata.lWO_Work wo
join stage.metadata.lWO_part_JB_of wojb on wojb.WO_ID_part=wo.WO_ID
join stage.metadata.ljb_job jb on jb.jb_id=wojb.JB_ID_of
join stage.metadata.lWO_formed_CF_from wocf on wocf.WO_ID_formed=wo.WO_ID
join stage.metadata.lCF_Configuration cf on cf.CF_ID=wocf.CF_ID_from
join stage.metadata.lWO_operates_CO_source_CO_target_OP_with woco on woco.WO_ID_operates=wo.WO_ID
join stage.metadata.lCO_Container cos on cos.CO_ID=woco.CO_ID_source
join stage.metadata.lCO_Container cot	on cot.CO_ID=woco.CO_ID_target

