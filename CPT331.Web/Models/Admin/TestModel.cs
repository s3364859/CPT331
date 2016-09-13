#region Using References

using System;

#endregion

namespace CPT331.Web.Models.Admin
{
    public class TestModel
    {
        public TestModel()
        {
        }

        public TestModel(int id, string value0, string value1)
        {
			_id = id;
			_value0 = value0;
			_value1 = value1;
        }

        private int _id;
        private bool _isDelete;
        private string _value0;
        private string _value1;

        public int ID
        {
            get
            {
                return _id;
            }
            set
            {
                _id = value;
            }
        }

        public bool IsDelete
        {
            get
            {
                return _isDelete;
            }
            set
            {
                _isDelete = value;
            }
        }

        public string Value0
        {
            get
            {
                return _value0;
            }
            set
            {
                _value0 = value;
            }
        }

        public string Value1
        {
            get
            {
                return _value1;
            }
            set
            {
                _value1 = value;
            }
        }
    }
}