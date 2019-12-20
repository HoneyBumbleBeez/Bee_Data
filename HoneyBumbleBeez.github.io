{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import pandas as pd\n",
    "from sqlalchemy import create_engine\n",
    "import os\n",
    "import numpy as np\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div>\n",
       "<style scoped>\n",
       "    .dataframe tbody tr th:only-of-type {\n",
       "        vertical-align: middle;\n",
       "    }\n",
       "\n",
       "    .dataframe tbody tr th {\n",
       "        vertical-align: top;\n",
       "    }\n",
       "\n",
       "    .dataframe thead th {\n",
       "        text-align: right;\n",
       "    }\n",
       "</style>\n",
       "<table border=\"1\" class=\"dataframe\">\n",
       "  <thead>\n",
       "    <tr style=\"text-align: right;\">\n",
       "      <th></th>\n",
       "      <th>Year</th>\n",
       "      <th>Period</th>\n",
       "      <th>State</th>\n",
       "      <th>Data</th>\n",
       "      <th>Count</th>\n",
       "    </tr>\n",
       "  </thead>\n",
       "  <tbody>\n",
       "    <tr>\n",
       "      <th>450</th>\n",
       "      <td>2017</td>\n",
       "      <td>JAN THRU MAR</td>\n",
       "      <td>ALABAMA</td>\n",
       "      <td>INVENTORY, MAX</td>\n",
       "      <td>7,000</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>451</th>\n",
       "      <td>2017</td>\n",
       "      <td>JAN THRU MAR</td>\n",
       "      <td>ARIZONA</td>\n",
       "      <td>INVENTORY, MAX</td>\n",
       "      <td>32,000</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>452</th>\n",
       "      <td>2017</td>\n",
       "      <td>JAN THRU MAR</td>\n",
       "      <td>ARKANSAS</td>\n",
       "      <td>INVENTORY, MAX</td>\n",
       "      <td>20,000</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>453</th>\n",
       "      <td>2017</td>\n",
       "      <td>JAN THRU MAR</td>\n",
       "      <td>CALIFORNIA</td>\n",
       "      <td>INVENTORY, MAX</td>\n",
       "      <td>1,440,000</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>454</th>\n",
       "      <td>2017</td>\n",
       "      <td>JAN THRU MAR</td>\n",
       "      <td>COLORADO</td>\n",
       "      <td>INVENTORY, MAX</td>\n",
       "      <td>21,000</td>\n",
       "    </tr>\n",
       "  </tbody>\n",
       "</table>\n",
       "</div>"
      ],
      "text/plain": [
       "     Year        Period       State            Data      Count\n",
       "450  2017  JAN THRU MAR     ALABAMA  INVENTORY, MAX      7,000\n",
       "451  2017  JAN THRU MAR     ARIZONA  INVENTORY, MAX     32,000\n",
       "452  2017  JAN THRU MAR    ARKANSAS  INVENTORY, MAX     20,000\n",
       "453  2017  JAN THRU MAR  CALIFORNIA  INVENTORY, MAX  1,440,000\n",
       "454  2017  JAN THRU MAR    COLORADO  INVENTORY, MAX     21,000"
      ]
     },
     "execution_count": 7,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "BS_file= \"Resources\\Survey_ByState.csv\"\n",
    "\n",
    "BS_df= pd.read_csv(BS_file, encoding='utf8')\n",
    "NewBee = BS_df.drop(['Week Ending', 'State ANSI', 'Watershed', 'CV (%)'], axis =1)\n",
    "NewBee.rename(columns = {'Data Item':'Data'}, inplace = True) \n",
    "\n",
    "NewBee.rename(columns = {'Value':'Count'}, inplace = True) \n",
    "NewBee1 = NewBee[NewBee.Data != 'ADDED & REPLACED']\n",
    "NewBee2= NewBee1[NewBee1.Data != \"LOSS, COLONY COLLAPSE DISORDER\"]\n",
    "NewBee3 = NewBee2[NewBee2.Data != \"LOSS, DEADOUT\"]\n",
    "NewBee3.head()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "Year       int64\n",
       "Period    object\n",
       "State     object\n",
       "Data      object\n",
       "Count     object\n",
       "dtype: object"
      ]
     },
     "execution_count": 8,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "NewBee3.dtypes"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "metadata": {},
   "outputs": [],
   "source": [
    "NewBee3['Count'].replace(regex=True,inplace=True,to_replace=r'\\D',value=r'')"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 214,
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "C:\\Users\\Crist\\Anaconda3\\lib\\site-packages\\ipykernel_launcher.py:1: SettingWithCopyWarning: \n",
      "A value is trying to be set on a copy of a slice from a DataFrame.\n",
      "Try using .loc[row_indexer,col_indexer] = value instead\n",
      "\n",
      "See the caveats in the documentation: http://pandas.pydata.org/pandas-docs/stable/indexing.html#indexing-view-versus-copy\n",
      "  \"\"\"Entry point for launching an IPython kernel.\n"
     ]
    }
   ],
   "source": [
    "NewBee3['Count'] = NewBee3['Count'].astype(str).astype(int)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 184,
   "metadata": {},
   "outputs": [],
   "source": [
    "mark_Newbee = NewBee[NewBee[\"Period\"] != \"MARKETING YEAR\"].copy()\n",
    "no_first_df = mark_Newbee[~mark_Newbee[\"Period\"].str.contains(\"FIRST\")].copy()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 185,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div>\n",
       "<style scoped>\n",
       "    .dataframe tbody tr th:only-of-type {\n",
       "        vertical-align: middle;\n",
       "    }\n",
       "\n",
       "    .dataframe tbody tr th {\n",
       "        vertical-align: top;\n",
       "    }\n",
       "\n",
       "    .dataframe thead th {\n",
       "        text-align: right;\n",
       "    }\n",
       "</style>\n",
       "<table border=\"1\" class=\"dataframe\">\n",
       "  <thead>\n",
       "    <tr style=\"text-align: right;\">\n",
       "      <th></th>\n",
       "      <th></th>\n",
       "      <th>Count</th>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Year</th>\n",
       "      <th>Period</th>\n",
       "      <th></th>\n",
       "    </tr>\n",
       "  </thead>\n",
       "  <tbody>\n",
       "    <tr>\n",
       "      <th rowspan=\"4\" valign=\"top\">2015</th>\n",
       "      <th>APR THRU JUN</th>\n",
       "      <td>4906840</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>JAN THRU MAR</th>\n",
       "      <td>4654550</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>JUL THRU SEP</th>\n",
       "      <td>4151340</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>OCT THRU DEC</th>\n",
       "      <td>4232700</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>2016</th>\n",
       "      <th>APR THRU JUN</th>\n",
       "      <td>5117880</td>\n",
       "    </tr>\n",
       "  </tbody>\n",
       "</table>\n",
       "</div>"
      ],
      "text/plain": [
       "                     Count\n",
       "Year Period               \n",
       "2015 APR THRU JUN  4906840\n",
       "     JAN THRU MAR  4654550\n",
       "     JUL THRU SEP  4151340\n",
       "     OCT THRU DEC  4232700\n",
       "2016 APR THRU JUN  5117880"
      ]
     },
     "execution_count": 185,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "x = no_first_df.groupby(['Year', 'Period']).sum()[[\"Count\"]]\n",
    "x.head()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.7.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 2
}
