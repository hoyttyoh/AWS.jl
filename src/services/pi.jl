# This file is auto-generated by AWSMetadata.jl
using AWS
using AWS.AWSServices: pi
using AWS.Compat
using AWS.UUIDs

"""
    describe_dimension_keys(end_time, group_by, identifier, metric, service_type, start_time)
    describe_dimension_keys(end_time, group_by, identifier, metric, service_type, start_time, params::Dict{String,<:Any})

For a specific time period, retrieve the top N dimension keys for a metric.   Each response
element returns a maximum of 500 bytes. For larger elements, such as SQL statements, only
the first 500 bytes are returned.

# Arguments
- `end_time`: The date and time specifying the end of the requested time series data. The
  value specified is exclusive, which means that data points less than (but not equal to)
  EndTime are returned. The value for EndTime must be later than the value for StartTime.
- `group_by`: A specification for how to aggregate the data points from a query result. You
  must specify a valid dimension group. Performance Insights returns all dimensions within
  this group, unless you provide the names of specific dimensions within this group. You can
  also request that Performance Insights return a limited number of values for a dimension.
- `identifier`: An immutable, Amazon Web Services Region-unique identifier for a data
  source. Performance Insights gathers metrics from this data source. To use an Amazon RDS
  instance as a data source, you specify its DbiResourceId value. For example, specify
  db-FAIHNTYBKTGAUSUZQYPDS2GW4A.
- `metric`: The name of a Performance Insights metric to be measured. Valid values for
  Metric are:    db.load.avg - A scaled representation of the number of active sessions for
  the database engine.     db.sampledload.avg - The raw number of active sessions for the
  database engine.    If the number of active sessions is less than an internal Performance
  Insights threshold, db.load.avg and db.sampledload.avg are the same value. If the number of
  active sessions is greater than the internal threshold, Performance Insights samples the
  active sessions, with db.load.avg showing the scaled values, db.sampledload.avg showing the
  raw values, and db.sampledload.avg less than db.load.avg. For most use cases, you can query
  db.load.avg only.
- `service_type`: The Amazon Web Services service for which Performance Insights will
  return metrics. Valid values are as follows:    RDS     DOCDB
- `start_time`: The date and time specifying the beginning of the requested time series
  data. You must specify a StartTime within the past 7 days. The value specified is
  inclusive, which means that data points equal to or greater than StartTime are returned.
  The value for StartTime must be earlier than the value for EndTime.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"AdditionalMetrics"`: Additional metrics for the top N dimension keys. If the specified
  dimension group in the GroupBy parameter is db.sql_tokenized, you can specify per-SQL
  metrics to get the values for the top N SQL digests. The response syntax is as follows:
  \"AdditionalMetrics\" : { \"string\" : \"string\" }.
- `"Filter"`: One or more filters to apply in the request. Restrictions:   Any number of
  filters by the same dimension, as specified in the GroupBy or Partition parameters.   A
  single filter for any other dimension in this dimension group.
- `"MaxResults"`: The maximum number of items to return in the response. If more items
  exist than the specified MaxRecords value, a pagination token is included in the response
  so that the remaining results can be retrieved.
- `"NextToken"`: An optional pagination token provided by a previous request. If this
  parameter is specified, the response includes only records beyond the token, up to the
  value specified by MaxRecords.
- `"PartitionBy"`: For each dimension specified in GroupBy, specify a secondary dimension
  to further subdivide the partition keys in the response.
- `"PeriodInSeconds"`: The granularity, in seconds, of the data points returned from
  Performance Insights. A period can be as short as one second, or as long as one day (86400
  seconds). Valid values are:     1 (one second)    60 (one minute)    300 (five minutes)
  3600 (one hour)    86400 (twenty-four hours)   If you don't specify PeriodInSeconds, then
  Performance Insights chooses a value for you, with a goal of returning roughly 100-200 data
  points in the response.
"""
function describe_dimension_keys(
    EndTime,
    GroupBy,
    Identifier,
    Metric,
    ServiceType,
    StartTime;
    aws_config::AbstractAWSConfig=global_aws_config(),
)
    return pi(
        "DescribeDimensionKeys",
        Dict{String,Any}(
            "EndTime" => EndTime,
            "GroupBy" => GroupBy,
            "Identifier" => Identifier,
            "Metric" => Metric,
            "ServiceType" => ServiceType,
            "StartTime" => StartTime,
        );
        aws_config=aws_config,
        feature_set=SERVICE_FEATURE_SET,
    )
end
function describe_dimension_keys(
    EndTime,
    GroupBy,
    Identifier,
    Metric,
    ServiceType,
    StartTime,
    params::AbstractDict{String};
    aws_config::AbstractAWSConfig=global_aws_config(),
)
    return pi(
        "DescribeDimensionKeys",
        Dict{String,Any}(
            mergewith(
                _merge,
                Dict{String,Any}(
                    "EndTime" => EndTime,
                    "GroupBy" => GroupBy,
                    "Identifier" => Identifier,
                    "Metric" => Metric,
                    "ServiceType" => ServiceType,
                    "StartTime" => StartTime,
                ),
                params,
            ),
        );
        aws_config=aws_config,
        feature_set=SERVICE_FEATURE_SET,
    )
end

"""
    get_dimension_key_details(group, group_identifier, identifier, service_type)
    get_dimension_key_details(group, group_identifier, identifier, service_type, params::Dict{String,<:Any})

Get the attributes of the specified dimension group for a DB instance or data source. For
example, if you specify a SQL ID, GetDimensionKeyDetails retrieves the full text of the
dimension db.sql.statement associated with this ID. This operation is useful because
GetResourceMetrics and DescribeDimensionKeys don't support retrieval of large SQL statement
text.

# Arguments
- `group`: The name of the dimension group. Performance Insights searches the specified
  group for the dimension group ID. The following group name values are valid:    db.query
  (Amazon DocumentDB only)    db.sql (Amazon RDS and Aurora only)
- `group_identifier`: The ID of the dimension group from which to retrieve dimension
  details. For dimension group db.sql, the group ID is db.sql.id. The following group ID
  values are valid:    db.sql.id for dimension group db.sql (Aurora and RDS only)
  db.query.id for dimension group db.query (DocumentDB only)
- `identifier`: The ID for a data source from which to gather dimension data. This ID must
  be immutable and unique within an Amazon Web Services Region. When a DB instance is the
  data source, specify its DbiResourceId value. For example, specify
  db-ABCDEFGHIJKLMNOPQRSTU1VW2X.
- `service_type`: The Amazon Web Services service for which Performance Insights returns
  data. The only valid value is RDS.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"RequestedDimensions"`: A list of dimensions to retrieve the detail data for within the
  given dimension group. If you don't specify this parameter, Performance Insights returns
  all dimension data within the specified dimension group. Specify dimension names for the
  following dimension groups:    db.sql - Specify either the full dimension name
  db.sql.statement or the short dimension name statement (Aurora and RDS only).    db.query -
  Specify either the full dimension name db.query.statement or the short dimension name
  statement (DocumentDB only).
"""
function get_dimension_key_details(
    Group,
    GroupIdentifier,
    Identifier,
    ServiceType;
    aws_config::AbstractAWSConfig=global_aws_config(),
)
    return pi(
        "GetDimensionKeyDetails",
        Dict{String,Any}(
            "Group" => Group,
            "GroupIdentifier" => GroupIdentifier,
            "Identifier" => Identifier,
            "ServiceType" => ServiceType,
        );
        aws_config=aws_config,
        feature_set=SERVICE_FEATURE_SET,
    )
end
function get_dimension_key_details(
    Group,
    GroupIdentifier,
    Identifier,
    ServiceType,
    params::AbstractDict{String};
    aws_config::AbstractAWSConfig=global_aws_config(),
)
    return pi(
        "GetDimensionKeyDetails",
        Dict{String,Any}(
            mergewith(
                _merge,
                Dict{String,Any}(
                    "Group" => Group,
                    "GroupIdentifier" => GroupIdentifier,
                    "Identifier" => Identifier,
                    "ServiceType" => ServiceType,
                ),
                params,
            ),
        );
        aws_config=aws_config,
        feature_set=SERVICE_FEATURE_SET,
    )
end

"""
    get_resource_metadata(identifier, service_type)
    get_resource_metadata(identifier, service_type, params::Dict{String,<:Any})

Retrieve the metadata for different features. For example, the metadata might indicate that
a feature is turned on or off on a specific DB instance.

# Arguments
- `identifier`: An immutable identifier for a data source that is unique for an Amazon Web
  Services Region. Performance Insights gathers metrics from this data source. To use a DB
  instance as a data source, specify its DbiResourceId value. For example, specify
  db-ABCDEFGHIJKLMNOPQRSTU1VW2X.
- `service_type`: The Amazon Web Services service for which Performance Insights returns
  metrics.

"""
function get_resource_metadata(
    Identifier, ServiceType; aws_config::AbstractAWSConfig=global_aws_config()
)
    return pi(
        "GetResourceMetadata",
        Dict{String,Any}("Identifier" => Identifier, "ServiceType" => ServiceType);
        aws_config=aws_config,
        feature_set=SERVICE_FEATURE_SET,
    )
end
function get_resource_metadata(
    Identifier,
    ServiceType,
    params::AbstractDict{String};
    aws_config::AbstractAWSConfig=global_aws_config(),
)
    return pi(
        "GetResourceMetadata",
        Dict{String,Any}(
            mergewith(
                _merge,
                Dict{String,Any}("Identifier" => Identifier, "ServiceType" => ServiceType),
                params,
            ),
        );
        aws_config=aws_config,
        feature_set=SERVICE_FEATURE_SET,
    )
end

"""
    get_resource_metrics(end_time, identifier, metric_queries, service_type, start_time)
    get_resource_metrics(end_time, identifier, metric_queries, service_type, start_time, params::Dict{String,<:Any})

Retrieve Performance Insights metrics for a set of data sources over a time period. You can
provide specific dimension groups and dimensions, and provide aggregation and filtering
criteria for each group.  Each response element returns a maximum of 500 bytes. For larger
elements, such as SQL statements, only the first 500 bytes are returned.

# Arguments
- `end_time`: The date and time specifying the end of the requested time series query
  range. The value specified is exclusive. Thus, the command returns data points less than
  (but not equal to) EndTime. The value for EndTime must be later than the value for
  StartTime.
- `identifier`: An immutable identifier for a data source that is unique for an Amazon Web
  Services Region. Performance Insights gathers metrics from this data source. In the
  console, the identifier is shown as ResourceID. When you call DescribeDBInstances, the
  identifier is returned as DbiResourceId. To use a DB instance as a data source, specify its
  DbiResourceId value. For example, specify db-ABCDEFGHIJKLMNOPQRSTU1VW2X.
- `metric_queries`: An array of one or more queries to perform. Each query must specify a
  Performance Insights metric, and can optionally specify aggregation and filtering criteria.
- `service_type`: The Amazon Web Services service for which Performance Insights returns
  metrics. Valid values are as follows:    RDS     DOCDB
- `start_time`: The date and time specifying the beginning of the requested time series
  query range. You can't specify a StartTime that is earlier than 7 days ago. By default,
  Performance Insights has 7 days of retention, but you can extend this range up to 2 years.
  The value specified is inclusive. Thus, the command returns data points equal to or greater
  than StartTime. The value for StartTime must be earlier than the value for EndTime.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"MaxResults"`: The maximum number of items to return in the response. If more items
  exist than the specified MaxRecords value, a pagination token is included in the response
  so that the remaining results can be retrieved.
- `"NextToken"`: An optional pagination token provided by a previous request. If this
  parameter is specified, the response includes only records beyond the token, up to the
  value specified by MaxRecords.
- `"PeriodInSeconds"`: The granularity, in seconds, of the data points returned from
  Performance Insights. A period can be as short as one second, or as long as one day (86400
  seconds). Valid values are:    1 (one second)    60 (one minute)    300 (five minutes)
  3600 (one hour)    86400 (twenty-four hours)   If you don't specify PeriodInSeconds, then
  Performance Insights will choose a value for you, with a goal of returning roughly 100-200
  data points in the response.
"""
function get_resource_metrics(
    EndTime,
    Identifier,
    MetricQueries,
    ServiceType,
    StartTime;
    aws_config::AbstractAWSConfig=global_aws_config(),
)
    return pi(
        "GetResourceMetrics",
        Dict{String,Any}(
            "EndTime" => EndTime,
            "Identifier" => Identifier,
            "MetricQueries" => MetricQueries,
            "ServiceType" => ServiceType,
            "StartTime" => StartTime,
        );
        aws_config=aws_config,
        feature_set=SERVICE_FEATURE_SET,
    )
end
function get_resource_metrics(
    EndTime,
    Identifier,
    MetricQueries,
    ServiceType,
    StartTime,
    params::AbstractDict{String};
    aws_config::AbstractAWSConfig=global_aws_config(),
)
    return pi(
        "GetResourceMetrics",
        Dict{String,Any}(
            mergewith(
                _merge,
                Dict{String,Any}(
                    "EndTime" => EndTime,
                    "Identifier" => Identifier,
                    "MetricQueries" => MetricQueries,
                    "ServiceType" => ServiceType,
                    "StartTime" => StartTime,
                ),
                params,
            ),
        );
        aws_config=aws_config,
        feature_set=SERVICE_FEATURE_SET,
    )
end

"""
    list_available_resource_dimensions(identifier, metrics, service_type)
    list_available_resource_dimensions(identifier, metrics, service_type, params::Dict{String,<:Any})

Retrieve the dimensions that can be queried for each specified metric type on a specified
DB instance.

# Arguments
- `identifier`: An immutable identifier for a data source that is unique within an Amazon
  Web Services Region. Performance Insights gathers metrics from this data source. To use an
  Amazon RDS DB instance as a data source, specify its DbiResourceId value. For example,
  specify db-ABCDEFGHIJKLMNOPQRSTU1VWZ.
- `metrics`: The types of metrics for which to retrieve dimensions. Valid values include
  db.load.
- `service_type`: The Amazon Web Services service for which Performance Insights returns
  metrics.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"MaxResults"`: The maximum number of items to return in the response. If more items
  exist than the specified MaxRecords value, a pagination token is included in the response
  so that the remaining results can be retrieved.
- `"NextToken"`: An optional pagination token provided by a previous request. If this
  parameter is specified, the response includes only records beyond the token, up to the
  value specified by MaxRecords.
"""
function list_available_resource_dimensions(
    Identifier, Metrics, ServiceType; aws_config::AbstractAWSConfig=global_aws_config()
)
    return pi(
        "ListAvailableResourceDimensions",
        Dict{String,Any}(
            "Identifier" => Identifier, "Metrics" => Metrics, "ServiceType" => ServiceType
        );
        aws_config=aws_config,
        feature_set=SERVICE_FEATURE_SET,
    )
end
function list_available_resource_dimensions(
    Identifier,
    Metrics,
    ServiceType,
    params::AbstractDict{String};
    aws_config::AbstractAWSConfig=global_aws_config(),
)
    return pi(
        "ListAvailableResourceDimensions",
        Dict{String,Any}(
            mergewith(
                _merge,
                Dict{String,Any}(
                    "Identifier" => Identifier,
                    "Metrics" => Metrics,
                    "ServiceType" => ServiceType,
                ),
                params,
            ),
        );
        aws_config=aws_config,
        feature_set=SERVICE_FEATURE_SET,
    )
end

"""
    list_available_resource_metrics(identifier, metric_types, service_type)
    list_available_resource_metrics(identifier, metric_types, service_type, params::Dict{String,<:Any})

Retrieve metrics of the specified types that can be queried for a specified DB instance.

# Arguments
- `identifier`: An immutable identifier for a data source that is unique within an Amazon
  Web Services Region. Performance Insights gathers metrics from this data source. To use an
  Amazon RDS DB instance as a data source, specify its DbiResourceId value. For example,
  specify db-ABCDEFGHIJKLMNOPQRSTU1VWZ.
- `metric_types`: The types of metrics to return in the response. Valid values in the array
  include the following:    os (OS counter metrics) - All engines    db (DB load metrics) -
  All engines except for Amazon DocumentDB    db.sql.stats (per-SQL metrics) - All engines
  except for Amazon DocumentDB    db.sql_tokenized.stats (per-SQL digest metrics) - All
  engines except for Amazon DocumentDB
- `service_type`: The Amazon Web Services service for which Performance Insights returns
  metrics.

# Optional Parameters
Optional parameters can be passed as a `params::Dict{String,<:Any}`. Valid keys are:
- `"MaxResults"`: The maximum number of items to return. If the MaxRecords value is less
  than the number of existing items, the response includes a pagination token.
- `"NextToken"`: An optional pagination token provided by a previous request. If this
  parameter is specified, the response includes only records beyond the token, up to the
  value specified by MaxRecords.
"""
function list_available_resource_metrics(
    Identifier, MetricTypes, ServiceType; aws_config::AbstractAWSConfig=global_aws_config()
)
    return pi(
        "ListAvailableResourceMetrics",
        Dict{String,Any}(
            "Identifier" => Identifier,
            "MetricTypes" => MetricTypes,
            "ServiceType" => ServiceType,
        );
        aws_config=aws_config,
        feature_set=SERVICE_FEATURE_SET,
    )
end
function list_available_resource_metrics(
    Identifier,
    MetricTypes,
    ServiceType,
    params::AbstractDict{String};
    aws_config::AbstractAWSConfig=global_aws_config(),
)
    return pi(
        "ListAvailableResourceMetrics",
        Dict{String,Any}(
            mergewith(
                _merge,
                Dict{String,Any}(
                    "Identifier" => Identifier,
                    "MetricTypes" => MetricTypes,
                    "ServiceType" => ServiceType,
                ),
                params,
            ),
        );
        aws_config=aws_config,
        feature_set=SERVICE_FEATURE_SET,
    )
end
