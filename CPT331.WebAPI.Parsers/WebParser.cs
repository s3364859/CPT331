#region Using References

using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;

#endregion

namespace CPT331.WebAPI.Parsers
{
	public class WebParser
	{
		protected WebParser(string url, string username, string password)
		{
			_url = url;
			_username = username;
			_password = password;
		}

		private readonly string _password;
		private readonly string _url;
		private readonly string _username;

		protected string Password
		{
			get
			{
				return _password;
			}
		}

		protected string Url
		{
			get
			{
				return _password;
			}
		}

		protected string Username
		{
			get
			{
				return _username;
			}
		}

		protected string Request(string endPoint)
		{
			return Request(endPoint, new Dictionary<string, string>());
		}

		protected string Request(string endPoint, Dictionary<string, string> queryStringValues)
		{
			string request = "";
			string requestUrl = $"{_url}{endPoint}";

			StringBuilder queryString = new StringBuilder();
			foreach (string key in queryStringValues.Keys)
			{
				string queryStringValue = $"{key}={queryStringValues[key]}";

				if (queryString.Length > 0)
				{
					queryString.Append("&");
				}

				queryString.Append(queryStringValue);
			}

			if (queryString.Length > 0)
			{
				requestUrl = $"{requestUrl}?{queryString.ToString()}";
			}

			HttpWebRequest httpWebRequest = (HttpWebRequest)(HttpWebRequest.Create(requestUrl));
			httpWebRequest.Credentials = new NetworkCredential(_username, _password);

			using (HttpWebResponse httpWebResponse = (HttpWebResponse)(httpWebRequest.GetResponse()))
			{
				using (StreamReader streamReader = new StreamReader(httpWebResponse.GetResponseStream()))
				{
					request = streamReader.ReadToEnd();
				}
			}

			return request;
		}
	}
}
